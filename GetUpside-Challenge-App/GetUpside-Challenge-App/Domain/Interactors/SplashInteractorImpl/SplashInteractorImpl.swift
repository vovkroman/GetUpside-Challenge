import Foundation

extension Splash {
    class InteractorImpl {
        
        private let _locationWorker: LocationWorkerable
        private weak var _coordinator: SplashCoordinatable?
        
        func fetchTheData() {
            if _locationWorker.isUserAuthorized {
                _locationWorker.requestLocation()
            } else {
                _locationWorker.requestForAutorization()
            }
        }
        
        func setCoorindator(
            _ coordinator: SplashCoordinatable?
        ) {
            // check for instance
            if coordinator === _coordinator { return }
            _coordinator = coordinator
        }
        
        init(
            _ location: LocationWorkerable
        ) {
            _locationWorker = location
        }
    }
}

extension Splash.InteractorImpl: LocationUpdating {
    func location(
        _ worker: LocationWorkerable,
        authStatusDidUpdated status: LocationStatus
    ) {
        
    }
    
    func location(
        _ worker: LocationWorkerable,
        locationDidUpdated locationCoordinate: Coordinate
    ) {
        
    }
    
    func location(
        _ worker: LocationWorkerable,
        catch error: Error
    ) {
        
    }
}
