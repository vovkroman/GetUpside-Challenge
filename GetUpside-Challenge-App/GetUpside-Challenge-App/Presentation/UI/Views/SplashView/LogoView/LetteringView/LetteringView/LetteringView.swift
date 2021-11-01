import UIKit

class LetteringView: UIView {
    
    // MARK: - Public methods
    
    var attributedString: NSAttributedString? {
        didSet {
            guard let cgPath = attributedString?.bezierPath?.cgPath else { return }
            layer.textPath = cgPath
        }
    }
    
    /// **start** - method should be call on start animation (make sure, **updateView**'s been invoked before)
    func startAnimating() {
        layer.start()
    }
    
    override var bounds: CGRect {
        didSet {
            /// **updateLayer** - calculates proper position of *bezierPath*
            layer.updateLayer()
        }
    }
    
    override class var layerClass: AnyClass {
        return LetteringLayer.self
    }

    override var layer: LetteringLayer {
        return super.layer as! LetteringLayer
    }
}
