import Foundation
import ArcGIS

extension Convertor {
    
    struct EateryConverter: Convertable {
        
        typealias From = AGSGeocodeResult
        typealias To = Eatery
        
        func convertFromTo(from: AGSGeocodeResult) throws -> Eatery {
            guard let coordinates = from.displayLocation?.toCLLocationCoordinate2D() else {
                throw Convertor.Error.convertFailed(context: "\(Eatery.self) can't be created as coordinates are missed")
            }
            let name = from.label
            let attributes = from.attributes
            return Eatery(coordinates: coordinates, name: name, payload: attributes)
        }
        
        func convertToFrom(from: Eatery) throws -> AGSGeocodeResult {
            // no need convert from Eatery.self to AGSGeocodeResult.self
            throw Error.convertFailed(context: "Could't convert item from \(Eatery.self) to \(AGSGeocodeResult.self)")
        }
    }
}
