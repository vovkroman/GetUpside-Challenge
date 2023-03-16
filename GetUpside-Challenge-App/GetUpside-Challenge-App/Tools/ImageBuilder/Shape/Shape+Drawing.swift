import UI

extension Shape {
    
//    func drawFilterIcon(_ rect: CGRect) -> UIBezierPath {
//
//        // draw filter icon
//        let path = UIBezierPath()
//
//        let width = 0.25 * rect.width
//        path.move(to: CGPoint(rect.minX, rect.minY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
//        path.addLine(to: CGPoint(x: 0.66 * rect.maxX - 0.25 * width, y: 0.33 * rect.maxY))
//        path.addLine(to: CGPoint(x: 0.66 * rect.maxX - 0.25 * width, y: 0.66 * rect.maxY))
//        path.addLine(to: CGPoint(x: 0.33 * rect.maxX + 0.25 * width, y: rect.maxY))
//        path.addLine(to: CGPoint(x: 0.33 * rect.maxX + 0.25 * width, y: 0.33 * rect.maxY))
//        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
//        path.close()
//
//        return path
//    }
    
    func drawPinIcon(_ rect: CGRect) -> UIBezierPath {
        // draw droplet icon
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



