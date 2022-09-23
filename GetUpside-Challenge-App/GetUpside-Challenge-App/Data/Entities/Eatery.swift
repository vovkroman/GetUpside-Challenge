import Foundation

struct Eatery {
    enum `Type`: String {
        
        case american = "American Food"
        case british = "British Isles Food"
        case burger = "Burgers"
        case chinese = "Chinese Food"
        case bakery = "Bakery"
        case international = "International Food"
        case coffeeShop = "Coffee Shop"
        case seafood = "Seafood"
        case fastFood = "Fast Food"
        case `default` = "Eatery"
    }
    
    let type: `Type`
    let coordinates: Coordinates
    let name: String
    let payload: [String: Any]?
}

extension Eatery.`Type`: ExpressibleByStringLiteral {
    
    typealias StringLiteralType = String
    
    init(stringLiteral value: String) {
        self = .init(rawValue: value) ?? .default
    }
}

extension Eatery.`Type`: ExpressibleByStringInterpolation {}
extension Eatery.`Type`: Equatable {}

extension Eatery: CustomStringConvertible {
    var description: String {
        switch type {
        case .american:
            return "american food"
        case .british:
            return "british food"
        case .burger:
            return "burger"
        case .chinese:
            return "中国菜"
        case .bakery:
            return "bakery"
        case .international:
            return "international food"
        case .coffeeShop:
            return "coffee shop"
        case .seafood:
            return "sea food"
        case .fastFood:
            return "fast food"
        case .default:
            return "eatery"
        }
    }
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
