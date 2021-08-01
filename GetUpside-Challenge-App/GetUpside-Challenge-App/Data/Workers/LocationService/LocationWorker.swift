import Foundation
import CoreLocation


typealias Coordinate = CLLocationCoordinate2D
typealias LocationStatus = CLAuthorizationStatus

// Interface for location worker
protocol LocationWorkerable: AnyObject {
    var isUserAuthorized: Bool { get }
    func requestForAutorization()
    
    func requestLocation()
    
    func stopUpdatingLocation()
    func startUpdatingLocation()
}

protocol LocationUpdating: AnyObject {
    func location(_ worker: LocationWorkerable, authStatusDidUpdated status: LocationStatus)
    func location(_ worker: LocationWorkerable, locationDidUpdated locationCoordinate: Coordinate)
    func location(_ worker: LocationWorkerable, catch error: Error)
}

extension Location {
    
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

extension Location.Worker: LocationWorkerable {
    var isUserAuthorized: Bool {
        return any(
            lhs: _authorizationStatus,
            rhs: .authorizedAlways, .authorizedWhenInUse
        )
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

