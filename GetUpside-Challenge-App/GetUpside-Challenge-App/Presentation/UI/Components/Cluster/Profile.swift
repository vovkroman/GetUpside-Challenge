import UIKit

extension Pin {
    
    enum Shape {
        case burger
        case restaurante
        case cafe
        
        func profile(_ rect: CGRect) -> Profile {
            switch self {
            case .burger:
                return .burger(rect: rect)
            case .restaurante:
                return .cover(rect: rect)
            case .cafe:
                return .cup(rect: rect)
            }
        }
    }
    
    enum Profile {
        case pin(rect: CGRect)
        case burger(rect: CGRect)
        case cover(rect: CGRect)
        case cup(rect: CGRect)
        
        var path: UIBezierPath {
            switch self {
            case .pin(let rect):
                return drawPin(rect)
            case .burger(let rect):
                return drawBurger(rect)
            case .cover(let rect):
                return drawCover(rect)
            case .cup(let rect):
                return drawCup(rect)
            }
        }
        
        // MARK: - Private methods
        
        private func drawCup(_ rect: CGRect) -> UIBezierPath {
            
            let width = rect.width
            let height = rect.height
            let minX = rect.minX
            let minY = rect.minY
            let maxY = rect.maxY
            let maxX = rect.maxX
            let centerY = rect.centerY
            
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
            handler.addArc(withCenter: CGPoint(maxX - 0.05 * width, centerY),
                           radius: 0.05 * width,
                           startAngle: 0,
                           endAngle: 2 * CGFloat.pi,
                           clockwise: true)
            cupPath.append(handler)
            
            return cupPath
        }
        
        private func drawCover(_ rect: CGRect) -> UIBezierPath {
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
        
        private func drawPin(_ rect: CGRect) -> UIBezierPath {
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
        
        private func drawBurger(_ rect: CGRect) -> UIBezierPath {
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
                               radius: height / 2,
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

}
