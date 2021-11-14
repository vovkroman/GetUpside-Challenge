import UIKit

final class ApplicationCoordinator: BaseCoordinator {
    
    private let _window: UIWindow
    private let _appDependencies: AppDependencies
    
    override func start(
        animated: Bool = true
    ) {
        let navigationController = _appDependencies.buildNavigationScene()
        navigationController.isNavigationBarHidden = true
        
        _window.rootViewController = navigationController
        _window.makeKeyAndVisible()
    
        // to coordinate to splash if we need to fetch some data (such as intial service requests)
        let splashCoordinator = Splash.Coordinator(
            navigationController,
            appDependecies: _appDependencies
        )
        splashCoordinator.parentCoordinator = self

        addDependency(splashCoordinator)
        coordinate(
            to: splashCoordinator,
            animated: animated
        )
    }
    
    init(
        window: UIWindow,
        appDependencies: AppDependencies
    ) {
        _window = window
        _appDependencies = appDependencies
    }
}
