import RealmSwift

extension Convertor {
    
    struct RealmEateryConverter: Convertable {
        typealias From = Results<RealmEatery>
        typealias To = [Eatery]
        typealias Error = Convertor.Error
        
        func convertFromTo(from: Results<RealmEatery>) throws -> [Eatery] {
            var eateries: [Eatery] = []
            for realm in from {
                guard let item = try? convertFromTo(from: realm) else { continue }
                eateries.append(item)
            }
            return eateries
        }
        
        func convertToFrom(from: [Eatery]) throws -> Results<RealmEatery> {
            // no need convert from Eatery.self to AGSGeocodeResult.self
            throw Error("Could't convert item from \([Eatery].self) to \(Results<RealmEatery>.self)")
        }
    }
}

private extension Convertor.RealmEateryConverter {
    func convertFromTo(from: RealmEatery) throws -> Eatery {
        var category: Eatery.Category = .default
        if !from.category.isEmpty {
            category = "\(from.category)"
        }
        var name: String = "Unknown"
        if !from.name.isEmpty {
            name = from.name
        }
        
        guard let location = from.location else {
            throw Error("Location for \(Eatery.self) might not be nil")
        }
        
        return Eatery(
            category: category,
            coordinates: Coordinates(
                latitude: location.latitude,
                longitude: location.longitude
            ),
            name: name,
            payload: nil
        )
    }
}

