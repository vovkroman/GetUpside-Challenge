import UIKit

extension UIColor {
    public func imageWithColor(_ size: CGSize) -> UIImage {
        let config = UIGraphicsImageRendererFormat()
        config.opaque = true
        return UIGraphicsImageRenderer(size: size, format: config).image { ctx in
            self.setFill()
            ctx.fill(CGRect(origin: .zero, size: size))
        }
    }
}
