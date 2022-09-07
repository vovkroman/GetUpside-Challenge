import Foundation

enum FoodApi {
    case getFood(location: Coordinates)
}

extension FoodApi: FetchType {
    
    var urlString: String {
        return "https://geocode-api.arcgis.com/arcgis/rest/services/World/GeocodeServer"
    }
    
    var searchResult: String {
        switch self {
        case .getFood:
            return ""
        }
    }
    
    var categories: [String] {
        switch self {
        case .getFood:
            return ["food"]
        }
    }
    
    var location: Coordinates? {
        switch self {
        case .getFood(let location):
            return location
        }
    }
    
    var maxResults: Int {
        return 20
    }
    
    var span: Double {
        return 1000
    }
}
