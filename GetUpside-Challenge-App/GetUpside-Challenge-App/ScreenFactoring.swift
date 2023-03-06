import UIKit

// MARK: - Specific Factory Interface

protocol AppNavigationable {
    func buildNavigationScene() -> UINavigationController
}

protocol SplashSceneFactoriable: AnyObject {
    func buildSplashScene(_ coordinator: AnyCoordinating<Splash.Event>) -> UIViewController
}

protocol MainSceneFactoriable {
    func buildMainScene(_ coordinator: AnyCoordinating<Main.Event>, _ entities: [Eatery]) -> UIViewController
}
