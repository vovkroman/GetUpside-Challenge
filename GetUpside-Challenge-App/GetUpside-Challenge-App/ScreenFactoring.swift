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

protocol SceneBuilder: AnyObject {
    func makeScene() -> UIViewController
}

// Specific Screen factories
final class SplashScreenBuilder: SceneBuilder {
        
    func makeScene() -> UIViewController {
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
        intercator.coordinator = coordinator.flatMap(AnyCoordinating.init)
        locationWorker.delegate = intercator
        
        let viewController = Splash.Scene(interactor: intercator)
        presenter.observer = viewController
        
        return viewController
    }
    
    weak var coordinator: Splash.Coordinator?
    private let _appDependecies: AppDependencies
    
    init(_ appDependencies: AppDependencies) {
        _appDependecies = appDependencies
    }
}
