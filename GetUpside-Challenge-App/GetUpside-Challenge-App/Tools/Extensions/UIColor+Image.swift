import UIKit

extension UIColor {
    func imageWithColor(_ size: CGSize) -> UIImage {
        let config = UIGraphicsImageRendererFormat()
        config.opaque = true
        return UIGraphicsImageRenderer(size: size, format: config).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
