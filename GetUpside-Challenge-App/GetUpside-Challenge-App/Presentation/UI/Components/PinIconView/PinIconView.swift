import UIKit

final class PinIconView: UIView {
    
    @IBInspectable
    var borderColor: UIColor = .darkGray
    
    @IBInspectable
    var fillColor: UIColor = .lightGray
    
    @IBInspectable
    var borderWidth: CGFloat = 1.0
        
    private let _shape: ShapeSupportable
    
    // MARK: - Life Cycle
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        _applyStyle(rect)
    }
    
    init(_ shape: ShapeSupportable, _ frame: CGRect) {
        self._shape = shape
        super.init(frame: frame)
    }
    
    // MARK: - Private API
    
    private func _setupPath(_ rect: CGRect) -> UIBezierPath {
        let bezierPath = UIBezierPath()
        let outer: Pin.Profile = .pin(rect: rect)
        bezierPath.append(outer.path)
        
        let _size = rect.size
        let profileRect = CGRect(center: rect.center, size: _size.apply(0.5))
        let inner: UIBezierPath = _shape.profile(profileRect)
        bezierPath.append(inner)
        
        return bezierPath
    }
    
    private func _applyStyle(_ rect: CGRect) {
        let bezierPath = _setupPath(rect)
        let path = bezierPath.cgPath
        _applyMask(path)
        _applyBorder(path)
    }
    
    private func _applyMask(_ path: CGPath) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path
        shapeLayer.fillRule = .evenOdd
        
        layer.mask = shapeLayer
        layer.contentsScale = UIScreen.main.scale
        layer.backgroundColor = fillColor.cgColor
    }
    
    private func _applyBorder(_ path: CGPath) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = path
        
        borderLayer.contentsScale = UIScreen.main.scale
        borderLayer.lineWidth = borderWidth
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        
        layer.addSublayer(borderLayer)
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
