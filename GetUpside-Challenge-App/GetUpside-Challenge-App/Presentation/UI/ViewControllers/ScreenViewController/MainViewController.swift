import UIKit

extension Main {
    final class Scene: BaseScene<MainView, InteractorImpl> {
        
        override func viewDidLoad() {
            super.viewDidLoad()
            interactor.initialSetup()
            
            contentView.tabBarMenu.delegate = self
            
            let mapVC = GoogleMapsViewController()
            mapVC.title = "Map"
            
            navigationItem.title = mapVC.title
            
            let listVC = UITableViewController()
            listVC.title = "List"
            
            contentView.add([mapVC, listVC], on: self)
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            contentView.updateLayout()
        }
        
        // MARK: - State handling
        private func _handleState(_ state: Main.StateMachine.State) {
            switch state {
            case .list(let viewModels):
                break
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
