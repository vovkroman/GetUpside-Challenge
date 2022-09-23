import UIKit

protocol ChildUpdatable: AnyObject {
    func update<ViewModel: Main.ViewModelable>(_ viewModels: ContiguousArray<ViewModel>)
}

extension Main {
    
    typealias ViewModelable = Namable & CoordinatesSupporting & Imagable & Typable
    typealias Childable = UIViewController & ChildUpdatable
    
    final class Scene: BaseScene<MainView, InteractorImpl> {
        
        private let _kids: ContiguousArray<Childable>
        
        // MARK: - Life Cycle of UIViewController
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            defer {
                interactor.setup()
            }
            
            contentView.tabBarMenu.delegate = self
            contentView.filterView.parentViewController = self

            if _kids.isEmpty { return }
            
            contentView.update(_kids[0].title)
            contentView.add(_kids, on: self)
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            contentView.updateLayout()
        }
        
        required init(_ interactor: InteractorImpl, _ kids: ContiguousArray<Childable>) {
            self._kids = kids
            super.init(interactor: interactor)
        }
        
        @available(*, unavailable)
        required init(interactor: T) {
            fatalError("init(interactor:) has not been implemented")
        }
        
        // MARK: - Private API
        
        private func _addItems(_ viewModels: ContiguousArray<ViewModel>) {
            for kid in _kids {
                kid.update(viewModels)
            }
        }
        
        private func _addFilters(_ viewModels: ContiguousArray<Filter.ViewModel>) {
            guard let controller = contentView.filterView.childViewController else {
                contentView.filterView.childViewController = Filter.ViewController(viewModels)
                return
            }
            controller
        }
        
        // MARK: - State handling
        
        private func _handleState(_ state: Main.StateMachine.State) {
            switch state {
            case .list(let response):
                _addItems(response.viewModels)
                _addFilters(response.filters)
            default:
                break
            }
        }
    }
}

extension Main.Scene: MainStateMachineObserver {
    func stateDidChanched(_ stateMachine: Main.StateMachine, _ to: Main.StateMachine.State) {
        DispatchQueue.main.async(execute: combine(to, with: _handleState))
    }
}

extension Main.Scene: TabBarMenuDelegate {
    func tabBarMenu(_ menu: TabBarMenuView, didSelected index: Int) {
        let vc = children[index]
        contentView.update(vc.title)
        view.bringSubviewToFront(vc.view)
    }
}
