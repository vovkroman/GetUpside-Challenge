import UIKit

open class PillLabel: MonochromeLabel, BorderApplicable {
    
    public weak var borderLayer: CAShapeLayer?
    
    public var isSelected: Bool = false {
        didSet {
            if isSelected {
                addBorder(Config(.black, .clear, 6.0))
            } else {
                removeBorder()
            }
        }
    }
    
    @IBInspectable
    public var padding: CGFloat  = 0.0
    
    public override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            size.width + 2 * padding,
            size.height + 2 * padding
        )
    }
    
    public override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(
            top: padding,
            left: padding,
            bottom: padding,
            right: padding
        )
        super.drawText(
            in: rect.inset(by: insets)
        )
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: 0.5 * bounds.height)
        applyPath(path)
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 0.5 * rect.height)
        let shape = CAShapeLayer()
        
        shape.path = path.cgPath
        
        layer.mask = shape
        layer.contentsScale = UIScreen.main.scale
    }
}
