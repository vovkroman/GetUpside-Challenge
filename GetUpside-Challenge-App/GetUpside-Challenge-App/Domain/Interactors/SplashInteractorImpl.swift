import Foundation

extension Splash {
    class InteractorImpl {
        
        private let _locationWorker: LocationWorkerable
        weak var coordinator: SplashCoordinatable?
        
        init(_ location: LocationWorkerable) {
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
