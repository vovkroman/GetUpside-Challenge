import Foundation
import CoreLocation

extension Location {
    
    typealias Coordinate = CLLocationCoordinate2D
    
    final class Worker: NSObject {
    
        private let _manager: CLLocationManager
        
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
        
        func checkCurrentStatus() {
            let authorizationStatus: CLAuthorizationStatus
            if #available(iOS 14.0, *) {
                authorizationStatus = _manager.authorizationStatus
            } else {
                authorizationStatus = CLLocationManager.authorizationStatus()
            }
            //stateMachine.transition(with: .authorizationChanged(status: authorizationStatus))
        }
        
        init(_ manager: CLLocationManager = .init()) {
            _manager = manager
            super.init()
            manager.delegate = self
        }
        
        deinit {
            _manager.stopUpdatingLocation()
        }
    }
}

extension Location.Worker: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus) {
        //stateMachine.transition(with: .authorizationChanged(status: status))
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        //stateMachine.transition(with: .locationDidChanged(location: location))
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error) {
        //stateMachine.transition(with: .faiedWithError(error: error))
    }
}

