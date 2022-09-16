import UIKit

final class PillLabel: MonochromeLabel {
    
    @IBInspectable
    var padding: CGFloat  = 0.0
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(size.width + 2 * padding,
                          size.height + 2 * padding)
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 0.5 * rect.height)
        let shape = CAShapeLayer()
        
        shape.path = path.cgPath
        
        layer.mask = shape
        layer.contentsScale = UIScreen.main.scale
    }
}
