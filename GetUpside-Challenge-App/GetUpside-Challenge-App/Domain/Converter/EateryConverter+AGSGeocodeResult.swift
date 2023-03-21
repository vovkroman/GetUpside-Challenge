import Foundation
import ArcGIS

extension Convertor {
    
    struct GeocodeEateryConverter: Convertable {
        
        private enum Keys {
            static let type = "Type"
        }
        
        typealias From = AGSGeocodeResult
        typealias To = Eatery
        typealias Error = Convertor.Error
        
        func convertFromTo(from: AGSGeocodeResult) throws -> Eatery {
            guard let coordinates = from.displayLocation?.toCLLocationCoordinate2D() else {
                throw Convertor.Error("\(Eatery.self) can't be created as coordinates are missed")
            }
            let name = from.label
            let attributes = from.attributes
            var category: Eatery.Category = .default
            if let str = attributes?[Keys.type] as? String {
                category = "\(str)"
            }
            return Eatery(
                category: category,
                coordinates: coordinates,
                name: name,
                payload: attributes
            )
        }
        
        func convertToFrom(from: Eatery) throws -> AGSGeocodeResult {
            // no need convert from Eatery.self to AGSGeocodeResult.self
            throw Error("Could't convert item from \(Eatery.self) to \(AGSGeocodeResult.self)")
        }
    }
}
