import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let appCoordinator: ApplicationCoordinator
    private let appDependencies: AppDependencies = AppDependencies()
    
    func application(_
                        application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        appDependencies.initializeServices()
        appCoordinator.start()

        return true
    }


    override init() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = ApplicationCoordinator(
            window: window,
            appDependencies: appDependencies
        )
        super.init()
    }
}
