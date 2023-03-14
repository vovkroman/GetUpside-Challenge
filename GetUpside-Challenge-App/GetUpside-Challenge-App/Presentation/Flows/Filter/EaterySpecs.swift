import FilterKit

struct DistanceSpec: Specification {
    
    typealias Item = Eatery
    
    private let currLocation: CurrentLocation
    private let radius: Double
    
    func isSatisfied(_ item: Item) -> Bool {
        let (latitude, longitude) = (item.coordinates.latitude, item.coordinates.longitude)
        let itemLocation = CurrentLocation(latitude: latitude, longitude: longitude)
        return currLocation.distance(from: itemLocation) <= radius
    }
    
    init(_ coordinates: Coordinates, _ radius: Double) {
        self.radius = radius
        self.currLocation = CurrentLocation(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
    }
}

struct CategorySpec: Specification {
    
    typealias Item = Eatery

    private let categoryId: String

    init(_ categoryId: String) {
        self.categoryId = categoryId
    }

    func isSatisfied(_ item: Item) -> Bool {
        return item.categoryId == categoryId
    }
}
