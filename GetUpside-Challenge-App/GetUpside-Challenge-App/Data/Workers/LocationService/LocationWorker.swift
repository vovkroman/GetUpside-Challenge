import Foundation
import CoreLocation

typealias Coordinate = CLLocationCoordinate2D
typealias LocationStatus = CLAuthorizationStatus
typealias OtherError = Error

// Interface for location worker
protocol LocationUseCase: AnyObject {
    var isUserAuthorized: Bool { get }
    func requestForAutorization()
    
    func requestLocation()
    
    func stopUpdatingLocation()
    func startUpdatingLocation()
}

protocol LocationUpdating: AnyObject {
    func location(_ worker: LocationUseCase, authStatusDidUpdated status: LocationStatus)
    func location(_ worker: LocationUseCase, locationDidUpdated locationCoordinate: Coordinate)
    func location(_ worker: LocationUseCase, catch error: Error)
}

extension Location {
    
    enum Error {
        case unknown
        case denied
        case restricted
        case other(OtherError)
    }
    
    final class Worker: NSObject {
    
        private let _manager: CLLocationManager
        weak var delegate: LocationUpdating?
        
        private var _authorizationStatus: CLAuthorizationStatus {
            let authorizationStatus: CLAuthorizationStatus
            if #available(iOS 14.0, *) {
                authorizationStatus = _manager.authorizationStatus
            } else {
                authorizationStatus = CLLocationManager.authorizationStatus()
            }
            return authorizationStatus
        }
        
        init(_ manager: CLLocationManager) {
            _manager = manager
            super.init()
            manager.delegate = self
        }
        
        deinit {
            _manager.stopUpdatingLocation()
        }
    }
}

extension Location.Worker: LocationUseCase {
    var isUserAuthorized: Bool {
        return any(value: _authorizationStatus, items: .authorizedAlways, .authorizedWhenInUse)
    }
    
    // MARK: - Public method
    func requestForAutorization() {
        _manager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        _manager.requestLocation()
    }
    
    func startUpdatingLocation() {
        _manager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        _manager.stopUpdatingLocation()
    }
}

extension Location.Worker: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus) {
        delegate?.location(self, authStatusDidUpdated: status)
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        delegate?.location(self, locationDidUpdated: location.coordinate)
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error) {
        delegate?.location(self, catch: error)
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

