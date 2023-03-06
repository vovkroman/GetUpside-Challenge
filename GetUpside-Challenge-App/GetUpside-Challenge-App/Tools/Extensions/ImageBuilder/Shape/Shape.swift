import UIKit
import CoreGraphics

protocol ImageDescription {
    var size: CGSize { get }
    var shape: Shape { get }
    var lineWidth: CGFloat { get }
    var fillColor: UIColor { get }
    var strokeColor: UIColor { get }
    var gradient: Gradient? { get }
}

struct Gradient {
    
    class Builder {
        var colors: [UIColor] = []
        var locations: [CGFloat] = []
    }
    
    typealias Block = (Builder) -> ()
    
    let cgGradient: CGGradient
    
    init?(_ block: Block) {
        let builder = Builder()
        block(builder)
        self.init(builder)
    }
    
    private init?(_ builder: Builder) {
        let colors = builder.colors
        let locations = builder.locations
        guard !colors.isEmpty,
              !locations.isEmpty else { return nil }
        let cgColors = colors.map{ $0.cgColor } as CFArray
        guard let gradient = CGGradient(
            colorsSpace: CGColorSpaceCreateDeviceRGB(),
            colors: cgColors,
            locations: locations
        ) else {
            return nil
        }
        self.cgGradient = gradient
    }
}

enum Shape {
    
    enum Inner {
        case burger
        case restaurant
        case cafe
        
        func draw(_ rect: CGRect) -> UIBezierPath {
            switch self {
                case .burger:
                    return drawBurger(rect)
                case .cafe:
                    return drawCup(rect)
                case .restaurant:
                    return drawCover(rect)
            }
        }
    }
    
    case circle(diameter: CGFloat)
    case rectangle(height: CGFloat, width: CGFloat)
    case pin(size: CGSize, inner: Inner)
    case emptyPin(size: CGSize)
    
    var bounds: CGRect {
        switch self {
        case .circle(let radius):
            let diameter = 2 * radius
            return CGRect(x: 0, y: 0, width: diameter, height: diameter)
        case .rectangle(let height, let width):
            return CGRect(origin: .zero, size: CGSize(height, width))
        case.pin(let size, _ ), .emptyPin(let size):
            let rect = CGRect(origin: .zero, size: size)
            return rect
        }
    }
    
    var path: UIBezierPath {
        switch self {
        case .circle(let radius):
            return UIBezierPath(roundedRect: bounds, cornerRadius: radius)
        case .rectangle(_, _):
            return UIBezierPath(rect: bounds)
        case .pin(_, let inner):
            let path = UIBezierPath()
            let outer = drawPin(bounds)
            path.append(outer)
            
            let size = bounds.size
            let profileRect = CGRect(center: bounds.center, size: size.apply(0.5))
            let inner: UIBezierPath = inner.draw(profileRect)
            path.append(inner)
            
            return path
        case .emptyPin(_):
            return drawPin(bounds)
        }
    }
}
