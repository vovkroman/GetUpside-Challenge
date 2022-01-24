import Foundation

struct Eatery {
    let coordinates: Coordinate
    let name: String
    let payload: [String: Any]?
}

extension Eatery: Hashable {
    
    static func == (lhs: Eatery, rhs: Eatery) -> Bool {
        return lhs.coordinates == rhs.coordinates && lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(coordinates.latitude)
        hasher.combine(coordinates.longitude)
        
        hasher.combine(name)
    }
}
