import UIKit

extension UIImage {
    static func circle(_ diameter: CGFloat, _ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: diameter, height: diameter)
        let path = UIBezierPath()
        path.addArc(withCenter: rect.center, radius: 0.5 * diameter - 10, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        path.close()
        
        return drawImage(path, color, color)
    }
    
    static func drawImage(_ path: UIBezierPath, _ fill: UIColor, _ stroke: UIColor) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.opaque = false
        format.scale = UIScreen.main.scale
        
        let renderer = UIGraphicsImageRenderer(bounds: path.bounds, format: format)
        let imag = renderer.image { ctx in
            
            path.lineWidth = 0.5
            
            stroke.setStroke()
            fill.setFill()
            
            path.usesEvenOddFillRule = true
            path.fill()
            path.stroke()
        }
        return imag
    }
}
