import UIKit

extension Main {
    final class Scene: BaseScene<MainView, InteractorImpl> {
        override func viewDidLoad() {
            super.viewDidLoad()
            
            interactor.requestLocation()
            
            contentView.tabBarMenu.delegate = self
            
            let mapVC = MapViewController()
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
    }
}

extension Main.Scene: TabBarMenuDelegate {
    func tabBarMenu(_ menu: TabBarMenuView, didSelected index: Int) {
        let vc = children[index]
        navigationItem.title = vc.title
        view.bringSubviewToFront(vc.view)
    }
}
