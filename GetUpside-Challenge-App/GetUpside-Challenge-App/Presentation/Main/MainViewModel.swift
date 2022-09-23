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

protocol Typable {
    var type: String { get }
}

extension Main {
    
    typealias Model = Eatery
    
    final class Builder {
        
        var image: UIImage = UIImage()
        var name: String = String()
        var coordonates: Coordinates = Coordinates()
        var type: String = String()
        
        private func defineShape(_ model: Model) -> Shape {
            switch model.type {
            case .american, .british, .chinese, .international, .seafood, .fastFood:
                return .restaurant
            case .burger:
                return .burger
            default:
                return .cafe
            }
        }
        
        func build(_ model: Model, _ size: CGSize) -> UIImage {
            return UIImage.drawImage(_buildPath(model, size), .lightGray, .darkGray)
        }
        
        private func _buildPath(_ model: Model, _ size: CGSize) -> UIBezierPath {
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
    
    final class ViewModel  {
        typealias BuilderBlock = (Builder) -> ()
        
        private let _name: String
        private let _image: UIImage
        private let _coordinates: Coordinates
        private let _type: String
        
        convenience init(_ block: BuilderBlock) {
            let builder = Builder()
            block(builder)
            self.init(builder)
        }
        
        init(_ builder: Builder) {
            _name = builder.name
            _image = builder.image
            _coordinates = builder.coordonates
            _type = builder.type
        }
    }
}

extension Main.ViewModel: Namable {
    var name: String {
        return _name
    }
}

extension Main.ViewModel: Imagable {
    
    var image: UIImage {
        return _image
    }
}

extension Main.ViewModel: CoordinatesSupporting {
    var coordinates: Coordinates {
        return _coordinates
    }
}

extension Main.ViewModel: Typable {
    var type: String {
        return _type
    }
}
