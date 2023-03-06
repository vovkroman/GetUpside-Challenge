import UIKit

enum RenderRequest {
    case pin(category: Eatery.Category, size: CGSize)
    case cluster(diameter: CGFloat)
}

extension RenderRequest: ImageDescription {
    
    var size: CGSize {
        switch self {
        case .pin(_, let size):
            return size
        case .cluster(let diameter):
            return CGSize(diameter, diameter)
        }
    }
    
    var shape: Shape {
        switch self {
        case .pin(let category, let size):
            switch category {
            case .burger:
                return .pin(size: size, inner: .burger)
            case .coffeeShop:
                return .pin(size: size, inner: .cafe)
            case .american, .bakery, .british, .chinese, .fastFood, .international, .seafood:
                return .pin(size: size, inner: .restaurant)
            default:
                return .emptyPin(size: size)
            }
        case .cluster(let diameter):
            return .circle(diameter: diameter)
        }
    }
    
    var lineWidth: CGFloat {
        switch self {
        case .pin:
            return 1.0
        case .cluster:
            return 0
        }
    }
    
    var fillColor: UIColor {
        switch self {
        case .cluster(_):
            return .clear
        case .pin:
            return .lightGray
        }
    }
    
    var strokeColor: UIColor {
        switch self {
        case .cluster:
            return .clear
        case .pin:
            return .gray
        }
    }
    
    var gradient: Gradient? {
        switch self {
        case .pin:
            return nil
        case .cluster:
            return Gradient { builder in
                builder.locations = [0.0, 1.0]
                builder.colors = [.darkGray, .clear]
            }
        }
    }
}
