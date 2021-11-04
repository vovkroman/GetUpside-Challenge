import ArcGIS
import GoogleMaps

protocol Serviceable {
    func setup()
}

struct GoogleMapsSetuper: Serviceable {
    
    private var _apiKey: String
        
    func setup() {
        GMSServices.provideAPIKey(_apiKey)
    }
    
    init(_ appConfigurator: ApplicationConfig) {
        _apiKey = appConfigurator.googleMapsKey
    }
}

struct ArcGISSetuper: Serviceable {
    
    private var _apiKey: String
    
    func setup() {
        AGSArcGISRuntimeEnvironment.apiKey = _apiKey
    }
    
    init(_ appConfigurator: ApplicationConfig) {
        _apiKey = appConfigurator.argisKey
    }
}

