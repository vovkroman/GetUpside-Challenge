import Foundation

extension CGPoint {
    init(_ x: CGFloat, _ y: CGFloat) {
        self.init(x: round(x), y: round(y))
    }
}
