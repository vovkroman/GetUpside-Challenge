import Foundation

class ApplicationConfig {
    
    enum Keys {
        case argis
        case googleMaps
    }
    
    lazy var argisKey: String = {
        return try! Configuration.value(for: "\(Keys.argis)")
    }()
    
    lazy var googleMapsKey: String = {
        return try! Configuration.value(for: "\(Keys.googleMaps)")
    }()
}

extension ApplicationConfig.Keys: CustomStringConvertible {
    var description: String {
        switch self {
        case .argis:
            return "ARGIS_KEY"
        case .googleMaps:
            return "GOOGLE_MAPS_KEY"
        }
    }
}
