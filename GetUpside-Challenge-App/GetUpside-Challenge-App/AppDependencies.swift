import Foundation
import CoreLocation

// Impl of DI conatiner
class AppDependencies {
    
    lazy private var _locationManager: CLLocationManager = {
/*  Though the code above is fine, it can be optimised to reduce power usage in the following ways:
// **desiredAccuracy** - This is documented in Core Location Constants,
         and the trick is that the more accurate the desired accuracy, the more antennas are turned on (which uses more power).
         E.g. if the desired accuracy is set to kCLLocationAccuracyKilometer,
         iOS won’t turn on the GPS or WiFi to get your location,
         and instead would just use the cell tower you’re connected to to get your location (this is good).
         If you set it to a high accuracy though (like kCLLocationAccuracyBest) then
         the device will have to turn on the GPS and / or WiFi to get your location (this is bad, and uses a LOT more power)
//  **distanceFilter** - What this does is filter location changes and not send them to the delegate callback.
         E.g. if you’re using the example code above,
         location changes of less than 5 metres won’t be sent to the callback, but instead be ignored.
         This is a bit of a trap though, as
         I’ve found it doesn’t actually affect which antennas are turned on like desiredAccuracy does,
         but just filters location changes instead.
 */
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = Constant.Location.kCLDistanceHundredMeters
        
        return locationManager
    }()
    
    lazy private var _queue: DispatchQueue = {
        let queue = DispatchQueue(label: "com.getUpside-challenge-global")
        return queue
    }()
}

extension AppDependencies: SceneFactoriable {
    func makeScene<Coordinator>(_ coordinator: Coordinator) -> UIViewController where Coordinator: Coordinating {
        return UIViewController()
    }
    
    func makeScene<Coordinator: Coordinating>(_ coordinator: Coordinator) -> UIViewController where Coordinator.Event == Splash.Event {
        let locationWorker = Location.Worker(_locationManager)
        let itemsWorker = ArcGis.Worker(AnyFetchRouter())
        let queue = DispatchQueue(
            label: "com.getUpside-challenge-splash",
            target: _queue
        )
        
        let presenter = Splash.Presenter(queue)
        let intercator = Splash.InteractorImpl(
            locationWorker,
            itemsWorker,
            presenter: presenter
        )
        intercator.coordinator = AnyCoordinating(coordinator)
        locationWorker.delegate = intercator
        let viewController = Splash.Scene(interactor: intercator)
        presenter.observer = viewController
        return viewController
    }
}
