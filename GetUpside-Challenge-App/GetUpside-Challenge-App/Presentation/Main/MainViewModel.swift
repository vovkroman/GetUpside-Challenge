import Foundation

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
    struct ViewModel  {
        typealias Model = Eatery
        
        private let _model: Model
        private var _image: UIImage!
        
        init(_ model: Model, _ size: CGSize) {
            _model = model
            _image = UIImage.drawImage(_buildPath(size), .lightGray, .darkGray)
        }
    }
}

extension Main.ViewModel: Namable {
    var name: String {
        return _model.name
    }
}

extension Main.ViewModel: Imagable {
    
    var image: UIImage {
        return _image
    }
    
    private func _buildPath(_ size: CGSize) -> UIBezierPath {
        let rect = CGRect(origin: .zero, size: size)
        
        let bezierPath = UIBezierPath()
        let outer: Pin.Profile = .pin(rect: rect)
        bezierPath.append(outer.path)
        
        let _size = rect.size
        let profileRect = CGRect(center: rect.center, size: _size.apply(0.5))
        let inner: UIBezierPath = _shape.profile(profileRect)
        bezierPath.append(inner)
        
        return bezierPath
    }
    
    private var _shape: Shape {
        switch _model {
        case .american, .british, .chinese, .international, .seafood, .fastFood:
            return .restaurant
        case .burger:
            return .burger
        default:
            return .cafe
        }
    }
}

extension Main.ViewModel: CoordinatesSupporting {
    var coordinates: Coordinates {
        return _model.coordinates
    }
}

extension Main.ViewModel: Typable {
    var type: String {
        return "\(_model)"
    }
}
