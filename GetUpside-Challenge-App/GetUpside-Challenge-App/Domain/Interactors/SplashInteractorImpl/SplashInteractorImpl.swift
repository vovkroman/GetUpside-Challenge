import Foundation

protocol LocationSupporting: AnyObject {
    func requestLocation()
}

protocol DataFetching: AnyObject {
    func fetchingData(_ coordinate: Coordinates)
}

protocol SplashUseCase: LocationSupporting, DataFetching {}

extension Splash {
    
    final class InteractorImpl {
        
        // workers
        let locationWorker: LocationUseCase
        let apiWorker: GetEateriesUseCase
        
        // navigation
        var coordinator: AnyCoordinating<Splash.Event>?
        
        private let presenter: SplashPresenterSupporting
        
        // State machine
        private(set) var stateMachine: StateMachine = StateMachine()
        let queue: DispatchQueue
        
        weak var observer: SplashStateMachineObserver? {
            didSet {
                stateMachine.observer = observer
            }
        }
        
        init(
            _ location: LocationUseCase,
            _ apiWorker: GetEateriesUseCase,
            _ queue: DispatchQueue,
            _ presenter: SplashPresenterSupporting
        ) {
            self.apiWorker = apiWorker
            self.locationWorker = location
            self.presenter = presenter
            self.queue = queue
        }
    }
}
