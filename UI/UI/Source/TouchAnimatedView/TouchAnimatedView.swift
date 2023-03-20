import UIKit

@IBDesignable
open class TouchAnimatedView: UIView {
    
    @IBInspectable
    open var radius: CGFloat = 10.0 {
        didSet {
           updateRadius(radius)
        }
    }
    
    @IBInspectable
    open var touchColor: UIColor = .gray {
        didSet {
            updateBackground(touchColor.cgColor)
        }
    }
    
    @IBInspectable
    open var duration: TimeInterval = 0.4
    
    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return nil
    }
    
    var config: Configuration {
        return Configuration(
            color: touchColor,
            radius: radius
        )
    }
    
    open func drawTouch(_ point: CGPoint) {
        let toCurrentViewPoint = convert(point, to: self)
        
        let diameter = 2 * radius
        let size = CGSize(diameter, diameter)
        let rect = CGRect(
            center: toCurrentViewPoint,
            size: size
        )
        let pulse = PulsingLayer(config, rect)
        layer.addSublayer(pulse)
        pulse.startAnimating(duration)
    }
}

private extension TouchAnimatedView {
    
    func updateRadius(_ radius: CGFloat) {
        guard let sublayers = layer.sublayers else {
            return
        }
        for subLayer in sublayers {
            let currFrame = subLayer.frame
            let center = currFrame.center
            let diameter = 2 * radius
            subLayer.frame = CGRect(
                center: center,
                size: CGSize(diameter, diameter)
            )
        }
    }
    
    func updateBackground(_ color: CGColor) {
        guard let sublayers = layer.sublayers else {
            return
        }
        for subLayer in sublayers {
            subLayer.backgroundColor = color
        }
    }
}
