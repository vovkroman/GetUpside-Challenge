import FilterKit

protocol MainUseCase: DataFetching, LocationSupporting, DataSaving {}
protocol MainPresenterSupporting {
    func onChangeLocation(_ coordinates: Coordinates)
}

extension Main {
    
    typealias Model = Eatery
    typealias Eateries = Set<Model>
    typealias Filters = Set<String>
    typealias EateryAccmulator = Accmulator<Model>
    
    final class InteractorImpl {
        
        // Workers
        let locationWorker: LocationUseCase
        let apiWorker: GetEateriesUseCase
        let dbWorker: EateriesSavable
        
        // Presenters
        let presenter: MainPresenterSupporting
        
        var eateries: Eateries
        var filters: Filters = []
        
        // accumulate eatery items for further persistence into local DB
        lazy var eateryAccumulator: EateryAccmulator = {
            let capacity = Constant.Main.accumulatorCapacity
            return EateryAccmulator(capacity)
        }()
        
        // App Observers
        var token: Any?
        
        var executor: FilterExecutor<String, Eatery> = FilterExecutor()
        
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
            _ dbWorker: EateriesSavable,
            _ presenter: MainPresenterSupporting,
            _ queue: DispatchQueue,
            _ eateries: [Model]
        ) {
            self.apiWorker = apiWorker
            self.locationWorker = location
            self.dbWorker = dbWorker
            self.presenter = presenter
            self.queue = queue
            self.eateries = Set(eateries)
            addObservers()
        }
    }
}
