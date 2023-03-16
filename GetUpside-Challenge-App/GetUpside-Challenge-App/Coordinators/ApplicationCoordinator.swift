import UIKit

final class ApplicationCoordinator: BaseCoordinator {
    
    private let window: UIWindow
    private let appDependencies: AppDependencies
    
    override func start(
        animated: Bool = true
    ) {
        let navigationController = appDependencies.buildNavigationScene()
        navigationController.isNavigationBarHidden = true
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    
        // to coordinate to splash if we need to fetch some data (such as intial service requests)
        let splashCoordinator = Splash.Coordinator(
            navigationController,
            appDependecies: appDependencies
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
        self.window = window
        self.appDependencies = appDependencies
    }
}
