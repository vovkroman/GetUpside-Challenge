import UIKit

public extension UIBezierPath {

    /// perform scale on UIBezierPath and keep the position in the path's center
    ///
    func scale(_ scale: CGFloat) {
        let bounds = cgPath.boundingBox
        
        let center = bounds.center
        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: center.x, y: center.y)
        transform = transform.scaledBy(x: scale, y: scale)
        transform = transform.translatedBy(x: -center.x, y: -center.y)
        apply(transform)
    }

    
    /// perform rotate on UIBezierPath and keep the center unchanged
    func rotate(_ radians:CGFloat) {
        let bounds = cgPath.boundingBox

        let center = bounds.center
        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: center.x, y: center.y)
        transform = transform.rotated(by: radians)
        transform = transform.translatedBy(x: -center.x, y: -center.y)
        apply(transform)
    }
    
    /// perform move on UIBezierPath and keep the center unchanged
    func move(_ dx: CGFloat, _ dy: CGFloat) {
        var transform = CGAffineTransform.identity
        transform = transform.translatedBy(x: dx, y: dy)
        apply(transform)
    }
}
