import Foundation

enum Eatery {
    struct Data {
        let coordinates: Coordinates
        let name: String
        let payload: [String: Any]?
    }
    
    case american(data: Data)
    case british(data: Data)
    case burger(data: Data)
    case chinese(data: Data)
    case bakery(data: Data)
    case international(data: Data)
    case coffeeShop(data: Data)
    case seafood(data: Data)
    case fastFood(data: Data)
    
    var coordinates: Coordinates {
        switch self {
        case .american(let data):
            return data.coordinates
        case .british(let data):
            return data.coordinates
        case .burger(let data):
            return data.coordinates
        case .chinese(let data):
            return data.coordinates
        case .bakery(let data):
            return data.coordinates
        case .international(let data):
            return data.coordinates
        case .coffeeShop(let data):
            return data.coordinates
        case .seafood(let data):
            return data.coordinates
        case .fastFood(let data):
            return data.coordinates
        }
    }
    
    var name: String {
        switch self {
        case .american(let data):
            return data.name
        case .british(let data):
            return data.name
        case .burger(let data):
            return data.name
        case .chinese(let data):
            return data.name
        case .bakery(let data):
            return data.name
        case .international(let data):
            return data.name
        case .coffeeShop(let data):
            return data.name
        case .seafood(let data):
            return data.name
        case .fastFood( let data):
            return data.name
        }
    }
}

extension Eatery: Hashable {
    static func == (lhs: Eatery, rhs: Eatery) -> Bool {
        switch (lhs, rhs) {
        case (.american(let lData), .american(let rData)),
             (.british(let lData), .british(let rData)),
            (.burger(let lData), .burger(let rData)),
            (.chinese(let lData), .chinese(let rData)),
            (.bakery(let lData), .bakery(let rData)),
            (.international(let lData), .international(let rData)),
            (.coffeeShop(let lData), .coffeeShop(let rData)),
            (.seafood(let lData), .seafood(let rData)),
            (.fastFood(let lData), .fastFood(let rData)):
            return lData.coordinates == rData.coordinates && lData.name == rData.name
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(coordinates.latitude)
        hasher.combine(coordinates.longitude)
        hasher.combine(name)
    }
}
