import UIKit

open class LetteringOverlay: UIView {
    
    // MARK: - Public methods
    
    public var attributedString: NSAttributedString? {
        didSet {
            guard let cgPath = attributedString?.bezierPath?.cgPath else { return }
            layer.textPath = cgPath
        }
    }
    
    public var config: Config = .default {
        didSet {
            layer.config = config
        }
    }
    
    open override var bounds: CGRect {
        didSet {
            /// **updateLayer** - calculates proper position of *bezierPath*
            layer.updateLayer()
        }
    }
    
    open override class var layerClass: AnyClass {
        return LetteringLayer.self
    }

    open override var layer: LetteringLayer {
        return super.layer as! LetteringLayer
    }
    
    /// **start** - method should be call on start animation;
    open func startAnimating() {
        layer.start()
    }
}
