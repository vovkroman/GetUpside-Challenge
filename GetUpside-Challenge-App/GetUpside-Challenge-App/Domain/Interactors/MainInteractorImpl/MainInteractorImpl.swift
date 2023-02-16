import Foundation

protocol MainUseCase: DataFetching, LocationSupporting {}
protocol MainPresentable: LocationPresenting & MainDataLoadable {}

extension Main {
    final class InteractorImpl {
        
        // Workers
        let locationWorker: LocationUseCase
        let apiWorker: GetEateriesUseCase
        
        // Presenters
        let presenter: MainPresentable
        var entities: Set<Eatery>
        
        var coordinator: AnyCoordinating<Main.Event>?
        
        // MARK: - Public methods
        
        init(
            _ location: LocationUseCase,
            _ apiWorker: GetEateriesUseCase,
            _ presenter: MainPresentable,
            _ entities: [Eatery]
        ) {
            self.apiWorker = apiWorker
            self.locationWorker = location
            self.presenter = presenter
            self.entities = Set(entities)
        }
    }
}

extension Main.InteractorImpl {
    
    func setup() {
        if entities.isEmpty { return }
        presenter.dataDidLoaded(entities)
    }
}
