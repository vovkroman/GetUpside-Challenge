import UIKit

extension Shape {
    
    func drawPin(_ rect: CGRect) -> UIBezierPath {
        // draw droplet shape
        let pinPath = UIBezierPath()
        let height = rect.height
        
        let dropletPath = UIBezierPath()
        dropletPath.addArc(withCenter: rect.center,
                           radius: 0.4 * height,
                           startAngle: 0.75 * CGFloat.pi,
                           endAngle: 0.25 * CGFloat.pi,
                           clockwise: true)
        dropletPath.addLine(to: CGPoint(rect.centerX, height))
        dropletPath.close()
        pinPath.append(dropletPath)
        
        let circlePath = UIBezierPath()
        circlePath.addArc(withCenter: rect.center,
                          radius: 0.3 * height,
                          startAngle: 0,
                          endAngle: 2 * CGFloat.pi, clockwise: true)
        pinPath.append(circlePath)
        
        return pinPath
    }
    
}



