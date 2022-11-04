import UIKit

@IBDesignable
open class BorderedButton: UIButton {

    @IBInspectable
    open var borderColor: UIColor = .white
    
    @IBInspectable
    open var fillColor: UIColor = .black
    
    @IBInspectable
    open var borderWidth: CGFloat = 1.0
    
    @IBInspectable
    open var cornerRadius: CGFloat = 4.0
    
    private unowned var _borderLayer: CAShapeLayer!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    public func setupView() {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.borderWidth = borderWidth
        borderLayer.fillColor = fillColor.cgColor
        _borderLayer = borderLayer
        layer.addSublayer(borderLayer)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let rectCorners: UIRectCorner = .allCorners
        
        let borderPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: rectCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        _borderLayer.path = borderPath.cgPath
    }
}
