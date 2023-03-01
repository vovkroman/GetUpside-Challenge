import Foundation

extension Main.InteractorImpl: LocationUpdating {
    func location(
        _ worker: LocationUseCase,
        authStatusDidUpdated status: LocationStatus
    ) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationWorker.startUpdatingLocation()
        case .denied: break
            //presenter.locationCatch(the: Location.Error.denied)
        case .restricted: break
            //presenter.locationCatch(the: Location.Error.restricted)
        default: // including not defined
            break
        }
    }
    
    func location(
        _ worker: LocationUseCase,
        locationDidUpdated locationCoordinate: Coordinates
    ) {
        //presenter.locationDidUpdated(with: locationCoordinate)
    }
    
    func location(
        _ worker: LocationUseCase,
        catch error: Error
    ) {
       // presenter.locationCatch(the: .other(error))
    }
}
