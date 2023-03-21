import UIKit

struct Configuration {
    let color: UIColor
    let radius: CGFloat
}

final class PulsingLayer: CALayer {
    
    let radius: CGFloat
    
    func startAnimating(_ duration: TimeInterval) {
        let animation = buildAnimation(duration)
        animation.delegate = self
        opacity = 0.0
        let id = Animation.KeyPath.self
        add(animation, forKey: "\(id.pulsing)")
    }
    
    init(_ config: Configuration, _ frame: CGRect) {
        radius = config.radius
        super.init()
        contentsScale = UIScreen.main.scale
        backgroundColor = config.color.cgColor
        self.frame = frame
        setupShape()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        mask = nil
        removeAllAnimations()
        print("\(self) has been removed")
    }
}

private extension PulsingLayer {
    
    func setupShape() {
        let circle = UIBezierPath(ovalIn: bounds)
        let shape = CAShapeLayer()
        shape.path = circle.cgPath
        mask = shape
    }
    
    func buildAnimation(_ duration: TimeInterval) -> CAAnimation {
        let animationGroup = CAAnimationGroup()
        
        func scale(_ scale: CGFloat) -> CABasicAnimation {
            let params = Animation.Params(
                from: CATransform3DIdentity,
                to: CATransform3DMakeScale(scale, scale, scale),
                duration: duration,
                timingFunc: CAMediaTimingFunction(name: .easeIn)
            )
            
            return CABasicAnimation(type: .transform(params: params))
        }
        
        func opacity() -> CABasicAnimation {
            let params = Animation.Params(
                from: [0.8],
                to: [0.0],
                duration: duration,
                timingFunc: CAMediaTimingFunction(name: .easeInEaseOut)
            )
            return CABasicAnimation(type: .opacity(params: params))
        }
        
        animationGroup.duration = duration
        animationGroup.repeatCount = 1
        animationGroup.animations = [
            scale(radius),
            opacity()
        ]
        return animationGroup
    }
}

extension PulsingLayer: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            mask = nil
            removeFromSuperlayer()
        }
    }
}
