import Foundation

extension Splash {
    final class InteractorImpl {
        
        private let _locationWorker: LocationWorkerable
        private var _presenter: SplashPresentable
        
        weak var coordinator: SplashCoordinatable?
        
        func fetchTheData() {
            if _locationWorker.isUserAuthorized {
                _locationWorker.startUpdatingLocation()
            } else {
                _locationWorker.requestForAutorization()
                _presenter.locationDidRequestForAuthorization()
            }
        }
        
        init(
            _ location: LocationWorkerable,
            presenter: SplashPresentable
        ) {
            _locationWorker = location
            _presenter = presenter
        }
    }
}

extension Splash.InteractorImpl: LocationUpdating {
    func location(
        _ worker: LocationWorkerable,
        authStatusDidUpdated status: LocationStatus
    ) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            _locationWorker.startUpdatingLocation()
        case .denied:
            _presenter.locationCatch(the: Location.Error.denied)
        case .restricted:
            _presenter.locationCatch(the: Location.Error.restricted)
        case .notDetermined:
            // nothing to do
            break
        }
    }
    
    func location(
        _ worker: LocationWorkerable,
        locationDidUpdated locationCoordinate: Coordinate
    ) {
        _presenter.locationDidUpdated(with: locationCoordinate)
    }
    
    func location(
        _ worker: LocationWorkerable,
        catch error: Error
    ) {
        _presenter.locationCatch(the: error)
    }
}
