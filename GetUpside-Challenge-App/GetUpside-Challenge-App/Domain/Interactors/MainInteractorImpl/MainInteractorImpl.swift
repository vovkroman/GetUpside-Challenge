import Foundation

protocol MainUseCase: DataFetching, LocationSupporting {}
protocol MainPresenterSupporting: MainDataLoadable {}

extension Main {
    
    typealias Eateries = Set<Eatery>
    typealias Filters = Set<String>
    
    final class InteractorImpl {
        
        // Workers
        let locationWorker: LocationUseCase
        let apiWorker: GetEateriesUseCase
        
        // Presenters
        private let presenter: MainPresenterSupporting
        
        var eateries: Eateries
        var filters: Filters = []
        
        var coordinator: AnyCoordinating<Main.Event>?
        
        // state machine
        let queue: DispatchQueue
        var stateMachine: StateMachine = StateMachine()
        
        weak var observer: MainStateMachineObserver? {
            didSet {
                stateMachine.observer = observer
            }
        }
        
        // MARK: - Public methods
        
        init(
            _ location: LocationUseCase,
            _ apiWorker: GetEateriesUseCase,
            _ presenter: MainPresenterSupporting,
            _ queue: DispatchQueue,
            _ eateries: [Eatery]
        ) {
            self.apiWorker = apiWorker
            self.locationWorker = location
            self.presenter = presenter
            self.queue = queue
            self.eateries = Set(eateries)
        }
    }
}
