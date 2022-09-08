import UIKit

protocol ChildUpdatable: AnyObject {
    func update(with items: [Main.ViewModel])
}

extension Main {
    
    typealias Childable = UIViewController & ChildUpdatable
    typealias Provider = () -> Childable
    
    final class Scene: BaseScene<MainView, InteractorImpl> {
        
        private var _providers: [Provider] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            contentView.tabBarMenu.delegate = self

            if _providers.isEmpty { return }
            var controllers: ContiguousArray<UIViewController> = []
            for provider in _providers {
                controllers.append(provider())
            }
            navigationItem.title = controllers[0].title
            
            contentView.add(controllers, on: self)
            
            interactor.initialSetup()
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            contentView.updateLayout()
        }
        
        func addItems(_ viewModels: [ViewModel]) {
            for child in children {
                (child as? MapViewController)?.update(with: viewModels)
            }
        }
        
        required init(_ interactor: InteractorImpl, _ providers: [Provider]) {
            self._providers = providers
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
