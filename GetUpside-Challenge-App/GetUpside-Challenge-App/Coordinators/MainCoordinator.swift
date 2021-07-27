import UIKit

protocol MainFactoriable {
    
}

extension Main {
    
    class Coordinator: BaseCoordinator {
        
        private let _navigationController: UINavigationController
        weak var parentCoordinator: ApplicationCoordinator?
        
        // MARK: - Public methods
        
        override func start(animated: Bool) {
            //let viewController = Main.ViewController(viewModel: )
            _navigationController.isNavigationBarHidden = false
            //_navigationController.setViewControllers([viewController], animated: animated)
        }
        
        init(_ navigationController: UINavigationController) {
            _navigationController = navigationController
        }
    }
}
