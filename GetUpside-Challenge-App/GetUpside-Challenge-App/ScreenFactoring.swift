import Foundation

protocol Coordinating: AnyObject {
    associatedtype Event
    func cacthTheEvent(_ event: Event)
    func catchTheError(_ error: Error)
}

class AnyCoordinating<T>: Coordinating {
    
    typealias Event = T
    
    private let _catchTheEvent: (Event) -> Void
    private let _catchTheError: (Error) -> Void
    
    func cacthTheEvent(_ event: T) {
        _catchTheEvent(event)
    }
    
    func catchTheError(_ error: Error) {
        _catchTheError(error)
    }
    
    init<Coordinator: Coordinating>(_ coordinator: Coordinator) where Coordinator.Event == T {
        _catchTheEvent = coordinator.cacthTheEvent
        _catchTheError = coordinator.catchTheError
    }
}

// MARK: - Specific Factory Interface

protocol SplashSceneFactoriable: AnyObject {
    func buildSplashScene(_ coordinator: AnyCoordinating<Splash.Event>) -> UIViewController
}

protocol MainSceneFactoriable {
    func buildMainScene(_ coordinator: AnyCoordinating<Main.Event>) -> UIViewController
}
