import Foundation

protocol LocationSupporting: AnyObject {
    func requestLocation()
}

protocol DataFetching: AnyObject {
    func fetachData(_ coordinate: Coordinates)
}

protocol SplashUseCase: LocationSupporting, DataFetching {}

extension Splash {
    
    final class InteractorImpl {
        
        // workers
        private let _locationWorker: LocationUseCase
        private let _apiWorker: GetEateriesUseCase
        
        private var _presenter: LocationPresenting
        
        var coordinator: AnyCoordinating<Splash.Event>?
        
        init(
            _ location: LocationUseCase,
            _ apiWorker: GetEateriesUseCase,
            presenter: LocationPresenting
        ) {
            _apiWorker = apiWorker
            _locationWorker = location
            _presenter = presenter
        }
    }
}

extension Splash.InteractorImpl: SplashUseCase {
    
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
            case .success(let items):
                self?.coordinator?.cacthTheEvent(items)
            case .failure(let error):
                self?._presenter.locationCatch(the: .other(error))
            case .failure(let error as NSError) where any(value: error.code, items: NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet):
                
                break
            }
        }
    }
    
    func cancelFetching() {
        _apiWorker.cancelFetching()
    }
}

extension Splash.InteractorImpl: LocationUpdating {
    func location(
        _ worker: LocationUseCase,
        authStatusDidUpdated status: LocationStatus
    ) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            // user's been authorized, but not got the current location
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
