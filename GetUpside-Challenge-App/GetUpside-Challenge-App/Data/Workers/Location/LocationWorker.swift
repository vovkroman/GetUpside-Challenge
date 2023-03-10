import FutureKit
import CoreLocation

typealias Coordinates = CLLocationCoordinate2D
typealias CurrentLocation = CLLocation
typealias LocationStatus = CLAuthorizationStatus
typealias OtherError = Error

// Interface for location worker
protocol LocationUseCase: AnyObject {
    
    var observer: Future<Coordinates> { get }
    func requestLocating()
}

extension Location {
    
    enum Error {
        case unknown
        case denied
        case restricted
        case other(OtherError)
    }
    
    final class Worker: NSObject {
    
        private let manager: CLLocationManager
        private var promise: RetainedPromise<Coordinates> = RetainedPromise()
        
        var observer: Future<Coordinates> {
            return promise
        }
        
        init(_ manager: CLLocationManager) {
            self.manager = manager
            super.init()
            self.manager.delegate = self
        }
        
        deinit {
            manager.stopUpdatingLocation()
        }
    }
}

extension Location.Worker: LocationUseCase {
    
    // MARK: - Public method
    
    func requestLocating() {
        manager.startUpdatingLocation()
    }
}

extension Location.Worker: CLLocationManagerDelegate {
    
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus) {
            permissionsDidChange(status)
        }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            promise.resolve(with: location.coordinate)
        }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error) {
            promise.reject(with: Location.Error.other(error))
        }
}

extension Location.Error: Error, CustomStringConvertible {
    var description: String {
        switch self {
        case .denied:
            return """
                User has explicitly denied authorization for this application, or
                location services are disabled in Settings.
                """
        case .restricted:
            return """
                  This application is not authorized to use location services. Due
                  to active restrictions on location services, You cannot change
                  this status, and may not have personally denied authorization.
                  """
        case .other(let error):
            return error.localizedDescription
        case .unknown:
            return "Location is currently unknown, but Location service will keep trying"
        }
    }
}

extension Location.Error: Equatable {
    static func == (
        lhs: Location.Error,
        rhs: Location.Error
    ) -> Bool {
        switch (lhs, rhs) {
        case (.unknown, .unknown),
             (.denied, .denied),
             (.restricted, .restricted):
            return true
        case (.other(let lhs), .other(let rhs)):
            return lhs.localizedDescription == rhs.localizedDescription
        default:
            return false
        }
    }
}

private extension Location.Worker {
    
    func permissionsDidChange(_ status: LocationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            // if user authorizedWhenInUse, service request location immidiatly
            manager.requestLocation()
        case .denied:
            promise.reject(with: Location.Error.denied)
        case .restricted:
            promise.reject(with: Location.Error.restricted)
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        @unknown default: break
            // nothing to do
        }
    }
}

