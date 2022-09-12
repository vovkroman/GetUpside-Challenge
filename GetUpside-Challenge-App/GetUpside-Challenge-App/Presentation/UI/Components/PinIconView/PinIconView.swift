import UIKit

final class PinIconView: UIView {
    private let _shape: Pin.Shape
    
    init(_ shape: Pin.Shape, _ frame: CGRect) {
        self._shape = shape
        super.init(frame: frame)
    }
    
    override func draw(_ rect: CGRect) {
        _applyMask(rect)
        
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 5.0
        layer.backgroundColor = UIColor.gray.cgColor
    }
    
    private func _applyMask(_ rect: CGRect) {
        let shapeLayer = CAShapeLayer()

        let bezierPath = UIBezierPath()
        let outer: Pin.Profile = .pin(rect: rect)
        bezierPath.append(outer.path)
        
        let size = rect.size
        let profileRect = CGRect(center: rect.center, size: size.apply(0.5))
        let inner: Pin.Profile = _shape.profile(profileRect)
        bezierPath.append(inner.path)
        shapeLayer.path = bezierPath.cgPath
        
        layer.addSublayer(shapeLayer)
        shapeLayer.fillRule = .evenOdd
        
        layer.mask = shapeLayer
    }
    
    @available(*, unavailable)
    override init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
