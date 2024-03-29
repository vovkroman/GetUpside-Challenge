import Foundation

struct Eatery {
    enum Category: String {
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
    
    let category: Category
    let coordinates: Coordinates
    let name: String
    let payload: [String: Any]?
}

extension Eatery: CustomStringConvertible {
    var description: String {
        switch category {
        case .american:
            return "american"
        case .british:
            return "british"
        case .burger:
            return "burger"
        case .chinese:
            return "chinese"
        case .bakery:
            return "bakery"
        case .international:
            return "international"
        case .coffeeShop:
            return "coffee shop"
        case .seafood:
            return "sea food"
        case .fastFood:
            return "fast food"
        case .default:
            return "not defined"
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

extension Eatery: Categorized, CoordinatesSupporting {
    var categoryId: String {
        return description
    }
}

// Category
extension Eatery.Category: ExpressibleByStringLiteral {
    
    typealias StringLiteralType = String
    
    init(stringLiteral value: String) {
        self = .init(rawValue: value) ?? .default
    }
}

extension Eatery.Category: ExpressibleByStringInterpolation {}
extension Eatery.Category: Equatable {}
