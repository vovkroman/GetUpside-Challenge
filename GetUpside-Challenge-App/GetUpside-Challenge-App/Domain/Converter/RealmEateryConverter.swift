import RealmSwift

extension Convertor {
    
    struct RealmEateryConverter: Convertable {
        typealias From = Array<RealmEatery>
        typealias To = [Eatery]
        typealias Error = Convertor.Error
        
        func convertFromTo(from: Array<RealmEatery>) throws -> [Eatery] {
            var eateries: [Eatery] = []
            for realm in from {
                guard let item = try? convertFromTo(from: realm) else { continue }
                eateries.append(item)
            }
            return eateries
        }
        
        func convertToFrom(from: [Eatery]) throws -> Array<RealmEatery> {
            return try from.map(convertFromTo)
        }
    }
}

private extension Convertor.RealmEateryConverter {
    
    func convertFromTo(from: Eatery) throws -> RealmEatery {
        let realmEatery = RealmEatery()
        realmEatery.name = from.name
        realmEatery.category = from.category.rawValue
        
        let coordinates = RealmCoordinates()
        coordinates.longitude = from.coordinates.longitude
        coordinates.latitude = from.coordinates.latitude
        realmEatery.coordinates = coordinates
        return realmEatery
    }
    
    func convertFromTo(from: RealmEatery) throws -> Eatery {
        var category: Eatery.Category = .default
        if !from.category.isEmpty {
            category = "\(from.category)"
        }
        var name: String = "Unknown"
        if !from.name.isEmpty {
            name = from.name
        }
        
        guard let coordinates = from.coordinates,
              !coordinates.longitude.isNaN,
              !coordinates.latitude.isNaN
        else {
            throw Error("Location for \(Eatery.self) might not be nil")
        }
        
        return Eatery(
            category: category,
            coordinates: Coordinates(
                latitude: coordinates.latitude,
                longitude: coordinates.longitude
            ),
            name: name,
            payload: nil
        )
    }
}

