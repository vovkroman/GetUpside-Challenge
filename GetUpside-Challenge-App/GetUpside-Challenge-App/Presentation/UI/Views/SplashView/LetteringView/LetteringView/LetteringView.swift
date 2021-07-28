import UIKit

final class LetteringView: UIView {
    
    // MARK: - Public methods
    
    var attributedString: NSAttributedString? {
        didSet {
            guard let cgPath = attributedString?.bezierPath?.cgPath else { return }
            layer.textPath = cgPath
        }
    }
    
    /// **updateView** - calculates proper position of *bezierPath*
    func updateView() {
        layer.updateLayer()
    }
    
    /// **start** - method should be call on start animation (make sure, **updateView**'s been invoked before)
    func start() {
        layer.start()
    }
    
    override class var layerClass: AnyClass {
        return LetteringLayer.self
    }

    override var layer: LetteringLayer {
        return super.layer as! LetteringLayer
    }
}
