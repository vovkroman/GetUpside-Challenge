import UIKit

public protocol BorderApplicable: AnyObject {
    var borderLayer: CAShapeLayer? { get set }
    
    func addBorder(_ config: Config)
    func removeBorder()
}

public extension BorderApplicable where Self: UIView {
    
    func addBorder(_ config: Config) {
        if let layer = borderLayer {
            layer.mask = nil
            layer.removeFromSuperlayer()
            borderLayer = nil
        }
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = config.stokeColor.cgColor
        borderLayer.lineWidth = config.lineWidth
        borderLayer.fillColor = config.fillColor.cgColor
        self.borderLayer = borderLayer
        layer.addSublayer(borderLayer)
    }
    
    func applyPath(_ path: UIBezierPath) {
        borderLayer?.path = path.cgPath
    }
    
    func removeBorder() {
        borderLayer?.removeFromSuperlayer()
    }
}

