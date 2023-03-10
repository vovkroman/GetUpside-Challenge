import UIKit
import CoreLocation

/// Impl of DI conatiner
class AppDependencies {
    
    lazy private var appConfig: ApplicationConfig = ApplicationConfig()
    
    
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
    lazy private var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = Constant.Location.kCLDistanceHundredMeters
        
        return locationManager
    }()
    
    lazy private var queue: DispatchQueue = {
        let queue = DispatchQueue(label: "com.getUpside-challenge-global")
        return queue
    }()
    
    func initialize() {
        let services: [Serviceable] = [ArcGISSetuper(appConfig), GoogleMapsSetuper(appConfig)]
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
        let locationWorker = Location.Worker(locationManager)
        let argisWorker = ArcGis.Worker(AnyFetchRouter())
        let localQueue = DispatchQueue(
            label: "com.getUpside-challenge-splash",
            target: queue
        )
        
        // build VIP cycle dependencies
        let presenter = Splash.Presenter()
        let interactor = Splash.InteractorImpl(
            locationWorker,
            argisWorker,
            localQueue,
            presenter
        )
        interactor.observer = presenter
        interactor.coordinator = coordinator
        let scene = Splash.Scene(interactor: interactor)
        presenter.view = scene
        return scene
    }
}

extension AppDependencies: MainSceneFactoriable {
    
    func buildMainScene(_ coordinator: AnyCoordinating<Main.Event>, _ entities: [Eatery]) -> UIViewController {
        let locationWorker = Location.Worker(locationManager)
        let argisWorker = ArcGis.Worker(AnyFetchRouter())
        let localQueue = DispatchQueue(
            label: "com.getUpside-challenge-main",
            target: queue
        )
        
        let presenter = Main.Presenter()
        let interactor = Main.InteractorImpl(
            locationWorker,
            argisWorker,
            presenter,
            localQueue,
            entities
        )
        
        interactor.observer = presenter
        
        let mapComponent = makedMapComponent("Map")
        let listComponent = makeListComponent("List")
        let filterComponent = makeFilterComponent()
        
        let scene = Main.Scene(
            interactor,
            [mapComponent, listComponent],
            filterComponent
        )
        mapComponent.delegate = scene
        filterComponent.delegate = scene
        
        presenter.view = scene
        return scene
    }
}

extension AppDependencies {
    func makeFilterComponent() -> Filter.Component {
        return Filter.Component()
    }
    
    func makedMapComponent(_ title: String) -> MapComponent {
        
        let scene = MapComponent()
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
    
    func makeListComponent(_ title: String) -> ListComponent {
        let scene = ListComponent()
        scene.title = title
        return scene
    }
}
