import Foundation

protocol MainUseCase: DataFetching, LocationSupporting {}
protocol MainPresentable: LocationPresenting & MainDataLoadable {}

extension Main {
    final class InteractorImpl {
        // Workers
        private let _locationWorker: LocationUseCase
        private let _apiWorker: GetEateriesUseCase
        
        // Presenters
        private let _presenter: MainPresentable
        private var _entities: Set<Eatery>
        
        var coordinator: AnyCoordinating<Main.Event>?
        
        // MARK: - Private methods
        
        private func _fetchNewEntities(_ entities: [Eatery]) {
            var new: Set<Eatery> = Set()
            for entity in entities {
                if _entities.contains(entity) { continue }
                _entities.insert(entity)
                new.insert(entity)
            }
            _presenter.dataDidLoaded(new)
        }
        
        // MARK: - Public methods
        
        func initialSetup() {
            if _entities.isEmpty { return }
            _presenter.dataDidLoaded(_entities)
        }
        
        init(
            _ location: LocationUseCase,
            _ apiWorker: GetEateriesUseCase,
            _ presenter: MainPresentable,
            _ entities: [Eatery]
        ) {
            _apiWorker = apiWorker
            _locationWorker = location
            _presenter = presenter
            _entities = Set(entities)
        }
    }
}

extension Main.InteractorImpl: MainUseCase {
    func requestLocation() {
        if _locationWorker.isUserAuthorized {
            _locationWorker.startUpdatingLocation()
        } else {
            _locationWorker.requestForAutorization()
            _presenter.locationDidRequestForAuthorization()
        }
    }
    
    func fetachData(_ coordinate: Coordinates) {
        _apiWorker.fetchData(coordinate).observe { [weak self] result in
            switch result {
            case .success(let entities):
                self?._fetchNewEntities(entities)
            case .failure(let error):
                //self?._presenter.locationCatch(the: .other(error))
                break
            }
        }
    }
}

extension Main.InteractorImpl: LocationUpdating {
    func location(
        _ worker: LocationUseCase,
        authStatusDidUpdated status: LocationStatus
    ) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            _locationWorker.startUpdatingLocation()
        case .denied:
            _presenter.locationCatch(the: Location.Error.denied)
        case .restricted:
            _presenter.locationCatch(the: Location.Error.restricted)
        default: // including not defined
            break
        }
    }
    
    func location(
        _ worker: LocationUseCase,
        locationDidUpdated locationCoordinate: Coordinates
    ) {
        _presenter.locationDidUpdated(with: locationCoordinate)
    }
    
    func location(
        _ worker: LocationUseCase,
        catch error: Error
    ) {
        _presenter.locationCatch(the: .other(error))
    }
}
