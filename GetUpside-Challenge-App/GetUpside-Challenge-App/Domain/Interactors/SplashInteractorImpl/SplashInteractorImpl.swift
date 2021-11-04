import Foundation

protocol SplashUseCase: AnyObject {
    associatedtype Request
    func requestLocation()
    func fetachData(_ request: Request)
}

extension Splash {
    
    struct Request {
        let coordinates: Coordinate
    }
    
    final class InteractorImpl {
        
        // workers
        private let _locationWorker: LocationUseCase
        private let _apiWorker: GetEateriesUseCase
        
        private var _presenter: SplashPresentable
        
        var coordinator: AnyCoordinating<Splash.Event>?
        
        init(
            _ location: LocationUseCase,
            _ apiWorker: GetEateriesUseCase,
            presenter: SplashPresentable
        ) {
            _apiWorker = apiWorker
            _locationWorker = location
            _presenter = presenter
        }
    }
}

extension Splash.InteractorImpl: SplashUseCase {
    
    typealias Request = Splash.Request
    
    func requestLocation() {
        if _locationWorker.isUserAuthorized {
            _locationWorker.startUpdatingLocation()
        } else {
            _locationWorker.requestForAutorization()
            _presenter.locationDidRequestForAuthorization()
        }
    }
    
    func fetachData(_ request: Request) {
        _apiWorker.fetchData(request.coordinates).observe { [weak self] result in
            switch result {
            case .success(let items):
                print(items)
                print(self?.coordinator)
                self?.coordinator?.cacthTheEvent(.items(items))
            case .failure(let error):
                self?._presenter.locationCatch(the: .other(error))
            }
        }
    }
}

extension Splash.InteractorImpl: LocationUpdating {
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
