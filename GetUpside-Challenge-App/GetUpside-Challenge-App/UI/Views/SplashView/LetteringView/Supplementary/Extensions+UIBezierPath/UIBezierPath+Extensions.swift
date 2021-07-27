import UIKit

extension NSAttributedString {
    var bezierPath: UIBezierPath? {
        let boundingRect = boundingRect(with: CGSize(width: Double.infinity, height: Double.infinity),
                                        options: .usesLineFragmentOrigin, context: nil)
        return UIBezierPath(forMultilineAttributedString: self,
                            maxWidth: ceil(boundingRect.size.width),
                            maxHeight: ceil(boundingRect.size.height));
    }
}
