import UIKit

protocol ChildUpdatable: AnyObject {
    func update<ViewModel: Main.ViewModelable>(_ viewModels: [ViewModel])
}

extension Main {
    
    typealias ViewModelable = Namable & CoordinatesSupporting & Shapable
    typealias Childable = UIViewController & ChildUpdatable
    
    final class Scene: BaseScene<MainView, InteractorImpl> {
        
        private let _kids: ContiguousArray<Childable>
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            defer {
                interactor.initialSetup()
            }
            
            contentView.tabBarMenu.delegate = self

            if _kids.isEmpty { return }
            
            navigationItem.title = _kids[0].title
            contentView.add(_kids, on: self)
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            contentView.updateLayout()
        }
        
        func addItems(_ viewModels: [ViewModel]) {
            for kid in _kids {
                kid.update(viewModels)
            }
        }
        
        required init(_ interactor: InteractorImpl, _ kids: ContiguousArray<Childable>) {
            self._kids = kids
            super.init(interactor: interactor)
        }
        
        @available(*, unavailable)
        required init(interactor: T) {
            fatalError("init(interactor:) has not been implemented")
        }
        
        // MARK: - State handling
        private func _handleState(_ state: Main.StateMachine.State) {
            switch state {
            case .list(let viewModels):
                addItems(viewModels)
            default:
                break
            }
        }
    }
}

extension Main.Scene: MainStateMachineObserver {
    func stateDidChanched(_ stateMachine: Main.StateMachine, to: Main.StateMachine.State) {
        DispatchQueue.main.async(execute: combine(to, with: _handleState))
    }
}

extension Main.Scene: TabBarMenuDelegate {
    func tabBarMenu(_ menu: TabBarMenuView, didSelected index: Int) {
        let vc = children[index]
        navigationItem.title = vc.title
        view.bringSubviewToFront(vc.view)
    }
}
