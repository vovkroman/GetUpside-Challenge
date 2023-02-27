import ArcGIS
import GoogleMaps

protocol Serviceable {
    func register()
}

struct GoogleMapsSetuper: Serviceable {
    
    private var _apiKey: String
        
    func register() {
        GMSServices.provideAPIKey(_apiKey)
    }
    
    init(_ appConfigurator: ApplicationConfig) {
        _apiKey = appConfigurator.googleMapsKey
    }
}

struct ArcGISSetuper: Serviceable {
    
    private var _apiKey: String
    
    func register() {
        AGSArcGISRuntimeEnvironment.apiKey = _apiKey
    }
    
    init(_ appConfigurator: ApplicationConfig) {
        _apiKey = appConfigurator.argisKey
    }
}

