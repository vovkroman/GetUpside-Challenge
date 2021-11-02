import Foundation

struct ApplicationConfig {
    
    enum Keys {
        case argis
    }
    
    lazy var argisKey: String = {
        return try! Configuration.value(for: "\(Keys.argis)")
    }()
}

extension ApplicationConfig.Keys: CustomStringConvertible {
    var description: String {
        switch self {
        case .argis:
            return "ARGIS_KEY"
        }
    }
}
