import Foundation

extension CGSize {
    func apply(_ multiplier: CGFloat) -> CGSize {
        return CGSize(width: multiplier * width, height: multiplier * height)
    }
}
