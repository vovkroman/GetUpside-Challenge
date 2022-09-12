import UIKit
import CoreLocation

// Impl of DI conatiner
class AppDependencies {
    
    lazy private var _appConfig: ApplicationConfig = ApplicationConfig()
    
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
    
    func setupServices() {
        let services: [Serviceable] = [ArcGISSetuper(_appConfig), GoogleMapsSetuper(_appConfig)]
        services.forEach{ $0.setup() }
    }
}

extension AppDependencies: AppNavigationable {
    func buildNavigationScene() -> UINavigationController {
        return AppNavigationController()
    }
}

extension AppDependencies: SplashSceneFactoriable {
    
    func buildSplashScene(_ coordinator: AnyCoordinating<Splash.Event>) -> UIViewController {
        let locationWorker = Location.Worker(_locationManager)
        let argisWorker = ArcGis.Worker(AnyFetchRouter())
        let queue = DispatchQueue(
            label: "com.getUpside-challenge-splash",
            target: _queue
        )
        
        let presenter = Splash.Presenter(queue)
        let interactor = Splash.InteractorImpl(
            locationWorker,
            argisWorker,
            presenter: presenter
        )
        interactor.coordinator = coordinator
        locationWorker.delegate = interactor
        let viewController = Splash.Scene(interactor: interactor)
        presenter.observer = viewController
        return viewController
    }
}

extension AppDependencies: MainSceneFactoriable {
    func buildMainScene(_ coordinator: AnyCoordinating<Main.Event>, _ entities: [Eatery]) -> UIViewController {
        let locationWorker = Location.Worker(_locationManager)
        let argisWorker = ArcGis.Worker(AnyFetchRouter())
        let queue = DispatchQueue(
            label: "com.getUpside-challenge-main",
            target: _queue
        )
        
        let presenter = Main.Presenter(queue)
        let interactor = Main.InteractorImpl(
            locationWorker,
            argisWorker,
            presenter,
            entities
        )
        
        locationWorker.delegate = interactor
        let map = buildMapScene()
        map.title = "Map"
        
        let list = buildListScene()
        list.title = "List"
        
        let viewController = Main.Scene(interactor, [map, list])
        presenter.observer = viewController
        return viewController
    }
    
    func buildMapScene() -> MapViewController {
        
        let viewController = MapViewController()
        /*
         Build cluster graph with the supplied icon generator and
         renderer
         */
        let mapView = viewController.contentView
        let iconGenerator = Cluster.IconGenerator(buckets: [10, 25, 50, 100], backgroundImages: [
                                                                                           UIImage.circle(diameter: 60, color: .black),
                                                                                           UIImage.circle(diameter: 80, color: .darkGray),
                                                                                           UIImage.circle(diameter: 100, color: .gray),
                                                                                           UIImage.circle(diameter: 120, color: .lightGray)])
        let algorithm = Cluster.Algorithm()
        let renderer = Cluster.Renderer(mapView: mapView,
                                        clusterIconGenerator: iconGenerator)
        
        let clusterManager = Cluster.Manager(map: mapView,
                                             algorithm: algorithm,
                                             renderer: renderer)
        
        viewController.clusterManager = clusterManager
        return viewController
    }
    
    func buildListScene() -> ListViewController {
        let viewController = ListViewController()
        return viewController
    }
}
