import Foundation

extension CGSize {
    
    init(_ width: CGFloat, _ height: CGFloat) {
        self.init(width: round(width), height: round(height))
    }
    
    func apply(_ multiplier: CGFloat) -> CGSize {
        return CGSize(multiplier * width, multiplier * height)
    }
}
