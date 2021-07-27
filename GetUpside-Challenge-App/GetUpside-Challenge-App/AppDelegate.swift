import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    private var _appCoordinator: ApplicationCoordinator?
    private let _appDependencies: AppDependencies = AppDependencies()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let applicationCoordinator = ApplicationCoordinator(window: window)
        applicationCoordinator.start()
        
        self._appCoordinator = applicationCoordinator
        
        return true
    }
}
