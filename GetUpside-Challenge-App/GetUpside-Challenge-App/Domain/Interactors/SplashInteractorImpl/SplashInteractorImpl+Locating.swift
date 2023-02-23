import Foundation

extension Splash.InteractorImpl: LocationUpdating {
    func location(
        _ worker: LocationUseCase,
        authStatusDidUpdated status: LocationStatus
    ) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
                // user's been authorized, but not got the current location
            locationWorker.startUpdatingLocation()
        case .denied:
            processTheError(.denied)
        case .restricted:
            processTheError(.restricted)
        default: // including not defined
            break
        }
    }
    
    func location(
        _ worker: LocationUseCase,
        locationDidUpdated locationCoordinate: Coordinates
    ) {
        locationCoordinateDidUpdated(locationCoordinate)
    }
    
    func location(
        _ worker: LocationUseCase,
        catch error: Error
    ) {
        processTheError(.other(error))
    }
}
