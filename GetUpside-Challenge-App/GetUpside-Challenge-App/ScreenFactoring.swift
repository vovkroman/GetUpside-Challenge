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

protocol SceneFactoring: AnyObject {
    associatedtype Event
    func makeScene(_ coordinator: AnyCoordinating<Event>) -> UIViewController
}

class AnyScreenFactoring<T>: SceneFactoring {
    
    typealias Event = T
    
    private let _makeScreen: (AnyCoordinating<T>) -> UIViewController
    
    func makeScene(_ coordinator: AnyCoordinating<T>) -> UIViewController {
        return _makeScreen(coordinator)
    }
    
    init<ScreenFactory: SceneFactoring>(_ factory: ScreenFactory) where ScreenFactory.Event == T {
        _makeScreen = factory.makeScene
    }
}

// Specific Screen factories
final class SplashScreenFactory: SceneFactoring {
    typealias Event = Splash.Event
    
    private let _appDependecies: AppDependencies
    
    func makeScene(_ coordinator: AnyCoordinating<Splash.Event>) -> UIViewController {
        let locationWorker = Location.Worker(_appDependecies.locationManager)
        let itemsWorker = ArcGis.Worker(AnyFetchRouter())
        let queue = DispatchQueue(
            label: "com.getUpside-challenge-splash",
            target: _appDependecies.queue
        )
        
        let presenter = Splash.Presenter(queue)
        let intercator = Splash.InteractorImpl(
            locationWorker,
            itemsWorker,
            presenter: presenter
        )
        intercator.coordinator = coordinator
        locationWorker.delegate = intercator
        
        let viewController = Splash.Scene(interactor: intercator)
        presenter.observer = viewController
        
        return viewController
    }
    
    init(_ appDependencies: AppDependencies) {
        _appDependecies = appDependencies
    }
}
