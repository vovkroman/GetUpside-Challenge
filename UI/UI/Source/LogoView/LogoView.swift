import UIKit

open class LogoView: LetteringOverlay {
    
//    override open func awakeFromNib() {
//        setup Layer presentation if view's been created via storyboard
//        layer.config = LetteringLayerConfig()
//    }
    
    public func setLogo(_ attrString: NSAttributedString) {
        attributedString = attrString
    }
}
