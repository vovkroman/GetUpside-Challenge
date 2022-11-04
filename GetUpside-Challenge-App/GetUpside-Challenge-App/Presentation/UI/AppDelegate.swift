import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let _appCoordinator: ApplicationCoordinator
    private let _appDependencies: AppDependencies = AppDependencies()
    
    func application(_
                        application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        _appDependencies.setupServices()
        _appCoordinator.start()

        return true
    }


    override init() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        _appCoordinator = ApplicationCoordinator(
            window: window,
            appDependencies: _appDependencies
        )
        super.init()
    }
}
