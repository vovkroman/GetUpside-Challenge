import UIKit

extension UIImage {
    class func circle(diameter: CGFloat, color: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: diameter, height: diameter))
        let img = renderer.image { ctx in
            ctx.cgContext.setFillColor(color.cgColor)

            let rectangle = CGRect(x: 0, y: 0, width: diameter, height: diameter)
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fill)
        }
        return img
    }
}
