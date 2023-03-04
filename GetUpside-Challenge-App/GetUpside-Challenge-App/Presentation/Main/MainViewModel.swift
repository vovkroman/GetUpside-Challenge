import Foundation
import UIKit

protocol Namable {
    var name: String { get }
}

protocol CoordinatesSupporting {
    var coordinates: Coordinates { get }
}

protocol Imagable {
    var image: UIImage { get }
}

protocol Categorized {
    var categoryId: String { get }
}

extension Main {
        
    final class Builder {
        
        var image: UIImage = UIImage()
        var name: String = String()
        var coordonates: Coordinates = Coordinates()
        var categoryId: String = String()
        
        private func defineShape(_ model: Eatery) -> Shape {
            switch model.category {
            case .american, .british, .chinese, .international, .seafood, .fastFood:
                return .restaurant
            case .burger:
                return .burger
            default:
                return .cafe
            }
        }
        
        func build(_ model: Eatery, _ size: CGSize) -> UIImage {
            return UIImage.drawImage(buildPath(model, size), .lightGray, .darkGray)
        }
        
        private func buildPath(_ model: Eatery, _ size: CGSize) -> UIBezierPath {
            let rect = CGRect(origin: .zero, size: size)
            
            let shape = defineShape(model)
            let bezierPath = UIBezierPath()
            let outer: Pin.Profile = Pin.Profile.pin(rect: rect)
            bezierPath.append(outer.path)
            
            let _size = rect.size
            let profileRect = CGRect(center: rect.center, size: _size.apply(0.5))
            let inner: UIBezierPath = shape.profile(profileRect)
            bezierPath.append(inner)
            
            return bezierPath
        }
    }
    
    struct ViewModel: Namable, Imagable, CoordinatesSupporting, Categorized  {
        
        typealias BuilderBlock = (Builder) -> ()
        
        let name: String
        let image: UIImage
        let coordinates: Coordinates
        let categoryId: String
        
        init(_ block: BuilderBlock) {
            let builder = Builder()
            block(builder)
            self.init(builder)
        }
        
        init(_ builder: Builder) {
            name = builder.name
            image = builder.image
            coordinates = builder.coordonates
            categoryId = builder.categoryId
        }
    }
}
