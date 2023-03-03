import UIKit

@IBDesignable
open class ErrordButton: UIButton, BorderApplicable {
    @IBInspectable
    open var borderColor: UIColor = .white
    
    @IBInspectable
    open var fillColor: UIColor = .black
    
    @IBInspectable
    open var borderWidth: CGFloat = 1.0
    
    @IBInspectable
    open var cornerRadius: CGFloat = 4.0
    
    public unowned var borderLayer: CAShapeLayer?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    public func setupView() {
        addBorder(Config(
            borderColor,
            fillColor,
            borderWidth)
        )
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let rectCorners: UIRectCorner = .allCorners
        let size = CGSize(cornerRadius, cornerRadius)
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: rectCorners,
                                cornerRadii: size)
        applyPath(path)
    }
}
