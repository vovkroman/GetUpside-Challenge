import UIKit

struct ImageRenderer {
    static func render<Request: ImageDescription>(_ request: Request) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.opaque = false
        format.scale = UIScreen.main.scale
        format.preferredRange = .standard
        
        let path = request.shape.path
        let bounds = path.bounds
        let renderer = UIGraphicsImageRenderer(bounds: bounds, format: format)
        
        let stroke = request.strokeColor
        let fill = request.fillColor
        
        return renderer.image { context in
            
            path.lineWidth = request.lineWidth
            path.usesEvenOddFillRule = true
            
            let radius = max(request.size.width, request.size.height) * 0.5
            if let gradient = request.gradient {
                context.cgContext.drawRadialGradient(gradient.cgGradient,
                                                     startCenter: bounds.center,
                                                     startRadius: 0,
                                                     endCenter: bounds.center,
                                                     endRadius: radius,
                                                     options: []
                )
    
            } else {
                
                stroke.setStroke()
                fill.setFill()
                
                path.fill()
                path.stroke()
            }
        }
    }
}
