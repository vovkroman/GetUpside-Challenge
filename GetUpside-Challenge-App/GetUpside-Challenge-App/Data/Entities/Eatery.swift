import Foundation
import ArcGIS

enum Eatery {
    struct Info {
        let title: String
        let coordinates: Coordinate
        let address: String
    }
    
    case coffeeShops(info: Info)
    case food(info: Info)
    
    init(result: AGSGeocodeResult) {
        self = .food(info: Info(title: "Mock", coordinates: .init(), address: ""))
    }
}
