import Foundation

protocol MainUseCase: SplashUseCase {
    
}

extension Main {
    final class InteractorImpl {
        // workers
        private let _locationWorker: LocationUseCase
        private let _apiWorker: GetEateriesUseCase
        
        private let _presenter: LocationPresenting
        
        var coordinator: AnyCoordinating<Splash.Event>?
        
        init(
            _ location: LocationUseCase,
            _ apiWorker: GetEateriesUseCase,
            _ presenter: LocationPresenting
        ) {
            _apiWorker = apiWorker
            _locationWorker = location
            _presenter = presenter
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
    
    func fetachData(_ coordinate: Coordinate) {
        _apiWorker.fetchData(coordinate).observe { [weak self] result in
            switch result {
            case .success(let items):
                print(items)
                //self?.coordinator?.cacthTheEvent(.items(items))
            case .failure(let error):
                print(error)
                //self?._presenter.locationCatch(the: .other(error))
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
        locationDidUpdated locationCoordinate: Coordinate
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
