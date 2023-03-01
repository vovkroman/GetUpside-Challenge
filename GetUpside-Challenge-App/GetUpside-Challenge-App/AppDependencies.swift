import UIKit
import CoreLocation

/// Impl of DI conatiner
class AppDependencies {
    
    lazy private var _appConfig: ApplicationConfig = ApplicationConfig()
    
    
    ///  Though the code above is fine, it can be optimised to reduce power usage in the following ways:
    /// **desiredAccuracy** - This is documented in Core Location Constants,
    /// and the trick is that the more accurate the desired accuracy, the more antennas are turned on (which uses more power).
    ///
    ///
    /// E.g. if the desired accuracy is set to kCLLocationAccuracyKilometer,
    /// iOS won’t turn on the GPS or WiFi to get your location,
    /// and instead would just use the cell tower you’re connected to to get your location (this is good).
    /// If you set it to a high accuracy though (like kCLLocationAccuracyBest) then
    /// the device will have to turn on the GPS and / or WiFi to get your location (this is bad, and uses a LOT more power)
    ///
    ///
    /// **distanceFilter** - What this does is filter location changes and not send them to the delegate callback.
    /// E.g. if you’re using the example code above,
    /// location changes of less than 5 metres won’t be sent to the callback, but instead be ignored.
    ///
    /// This is a bit of a trap though, as
    /// I’ve found it doesn’t actually affect which antennas are turned on like desiredAccuracy does,
    /// but just filters location changes instead.
    lazy private var _locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = Constant.Location.kCLDistanceHundredMeters
        
        return locationManager
    }()
    
    lazy private var _queue: DispatchQueue = {
        let queue = DispatchQueue(label: "com.getUpside-challenge-global")
        return queue
    }()
    
    func initialize() {
        let services: [Serviceable] = [ArcGISSetuper(_appConfig), GoogleMapsSetuper(_appConfig)]
        services.forEach{ $0.register() }
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
        
        // build VIP cycle dependencies
        let presenter = Splash.Presenter()
        let interactor = Splash.InteractorImpl(
            locationWorker,
            argisWorker,
            queue,
            presenter
        )
        interactor.observer = presenter
        interactor.coordinator = coordinator
        locationWorker.delegate = interactor
        let scene = Splash.Scene(interactor: interactor)
        presenter.view = scene
        return scene
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
        
        let presenter = Main.Presenter()
        let interactor = Main.InteractorImpl(
            locationWorker,
            argisWorker,
            presenter,
            queue,
            entities
        )
        
        interactor.observer = presenter
        
        locationWorker.delegate = interactor
        
        let scene = Main.Scene(
            interactor,
            [buildMapScene("Map"), buildListScene("List")],
            buildFilterScene()
        )
        presenter.view = scene
        return scene
    }
    
    func buildFilterScene() -> Filter.ViewController {
        return Filter.ViewController()
    }
    
    func buildMapScene(_ title: String) -> MapViewController {
        
        let scene = MapViewController()
        scene.title = title

        /// Build cluster graph with the supplied icon generator and renderer
        ///
        let mapView = scene.contentView
        let iconGenerator = Constant.Map.iconGenerator
        let algorithm = Cluster.Algorithm()
        let renderer = Cluster.Renderer(
            mapView: mapView,
            clusterIconGenerator: iconGenerator
        )
        
        let clusterManager = Cluster.Manager(
            map: mapView,
            algorithm: algorithm,
            renderer: renderer
        )

        scene.clusterManager = clusterManager
        return scene
    }
    
    func buildListScene(_ title: String) -> ListViewController {
        let scene = ListViewController()
        scene.title = title
        return scene
    }
}
