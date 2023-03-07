import UIKit

extension Shape.Inner {
    
    func drawCupIcon(_ rect: CGRect) -> UIBezierPath {
        
        let width = rect.width
        let height = rect.height
        let minX = rect.minX
        let minY = rect.minY
        let maxY = rect.maxY
        let maxX = rect.maxX
        let centerY = rect.centerY
        let centerX = rect.centerX
        
        let cupPath = UIBezierPath()
        
        let bowlPath = UIBezierPath()
        bowlPath.move(to: CGPoint(minX + 0.1 * width,
                                  minY + 0.2 * height))
        bowlPath.addQuadCurve(to: CGPoint(minX + 0.4 * width,
                                          maxY - 0.2 * height),
                              controlPoint: CGPoint(minX, centerY))
        bowlPath.addLine(to: CGPoint(maxX - 0.4 * width, maxY - 0.2 * height))
        bowlPath.addQuadCurve(to: CGPoint(maxX - 0.1 * width,
                                          minY + 0.2 * height),
                              controlPoint: CGPoint(maxX, centerY))
        bowlPath.close()
        
        cupPath.append(bowlPath)
        
        let handler = UIBezierPath()
        handler.addArc(withCenter: CGPoint(maxX - 0.1 * width, centerY),
                       radius: 0.1 * width,
                       startAngle: 1.5 * CGFloat.pi ,
                       endAngle: 0.75 * CGFloat.pi,
                       clockwise: true)
        handler.close()
        cupPath.append(handler)
        
        let saucerPath = UIBezierPath()
        saucerPath.move(to: CGPoint(minX + 0.15 * width, maxY - 0.15 * height))
        saucerPath.addQuadCurve(to: CGPoint(maxX - 0.15 * width, maxY - 0.15 * height), controlPoint: CGPoint(centerX, maxY))
        saucerPath.close()
        cupPath.append(saucerPath)
        
        return cupPath
    }
    
    func drawCoverIcon(_ rect: CGRect) -> UIBezierPath {
        let width = rect.width
        let height = rect.height
        let centerX = rect.centerX
        let centerY = rect.centerY
        
        let minX = rect.minX
        let minY = rect.minY
        
        let platePath = UIBezierPath()
        //up сover
        let upCoverPath = UIBezierPath()
        upCoverPath.addArc(withCenter: CGPoint(centerX,
                                                 centerY + 0.2 * height),
                           radius: 0.5 * width,
                           startAngle: CGFloat.pi,
                           endAngle: 0,
                           clockwise: true)
        upCoverPath.addLine(to: CGPoint(minX, minY + 0.7 * height))
        upCoverPath.close()
        
        platePath.append(upCoverPath)
        
        // handler
        let handlerPath = UIBezierPath()
        handlerPath.addArc(withCenter: CGPoint(centerX, minY + height * 0.1),
                           radius: height * 0.05,
                           startAngle: 0,
                           endAngle: 2 * CGFloat.pi,
                           clockwise: true)
        handlerPath.close()
        
        platePath.append(handlerPath)
        
        return platePath
    }
    
    func drawBurgerIcon(_ rect: CGRect) -> UIBezierPath {
        let width = rect.width
        let height = rect.height
        let centerY = rect.centerY
        let minX = rect.minX
        let maxX = rect.maxX
        let minY = rect.minY

        //up сover
        let burgerPath = UIBezierPath()
        
        let upCoverPath = UIBezierPath()
        upCoverPath.addArc(withCenter: rect.center,
                           radius: 0.5 * height,
                           startAngle: CGFloat.pi,
                           endAngle: 0,
                           clockwise: true)
        upCoverPath.close()
        
        burgerPath.append(upCoverPath)
        
        // cotlet
        let cotletPath = UIBezierPath()
        cotletPath.move(to: CGPoint(minX, centerY + 0.05 * height))
        cotletPath.addLine(to: CGPoint(maxX,
                                       centerY + 0.05 * height))
        cotletPath.addLine(to: CGPoint(maxX,
                                       centerY + 0.15 * height))
        cotletPath.addLine(to: CGPoint(minX,
                                       centerY + 0.15 * height))
        cotletPath.close()
        
        burgerPath.append(cotletPath)
        
        // down cover
        let downCoverPath = UIBezierPath()
        downCoverPath.move(to: CGPoint(minX,
                                       centerY + 0.2 * height))
        downCoverPath.addArc(withCenter: CGPoint(minX + 0.1 * width,
                                                 minY + 0.8 * height),
                             radius: 0.1 * height,
                             startAngle: CGFloat.pi,
                             endAngle: 0.5 * CGFloat.pi, clockwise: false)
        downCoverPath.move(to: CGPoint(minX,
                                       minY + 0.7 * height))
        downCoverPath.addLine(to: CGPoint(maxX,
                                          minY + 0.7 * height))
        
        downCoverPath.addArc(withCenter: CGPoint(minX + 0.9 * width,
                                                 minY + 0.8 * height),
                             radius: 0.1 * height,
                             startAngle: 0.0,
                             endAngle: 0.5 * CGFloat.pi, clockwise: true)
        downCoverPath.addLine(to: CGPoint(minX + 0.1 * width,
                                          minY + 0.9 * height))
        
        burgerPath.append(downCoverPath)
        return burgerPath
    }
}
