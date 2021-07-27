import UIKit

class ApplicationCoordinator: BaseCoordinator {
    
    private let _window: UIWindow
    
    override func start(animated: Bool = true) {
        let navigationController = UINavigationController()
        navigationController.isNavigationBarHidden = true
        
        _window.rootViewController = navigationController
        _window.makeKeyAndVisible()
    
        // to coordinate to splash if we need to fetch some data (such as intial service requests)
        let splashCoordinator = Splash.Coordinator(navigationController)
        splashCoordinator.parentCoordinator = self

        addDependency(splashCoordinator)
        coordinate(to: splashCoordinator, animated: animated)
        
//        let mainCoordinator = Main.Coordinator(navigationController)
//        mainCoordinator.parentCoordinator = self
//
//
//        addDependency(mainCoordinator)
//        coordinate(to: mainCoordinator)
        // to coordinate to main screen if we need to pass to main flow
    }
    
    init(window: UIWindow) {
        _window = window
    }
}
