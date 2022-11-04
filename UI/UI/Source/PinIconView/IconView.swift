import UIKit

public protocol Animatable: AnyObject {
    func startAnimation()
    func endAnimation()
}

public class IconView: UIImageView {}

extension IconView: Animatable {
    
    public func startAnimation() {
        let animation = CABasicAnimation(type: .transform(params: Animation.Params(
            from: CATransform3DIdentity,
            to: CATransform3DMakeRotation(.pi, 0.0, 1.0, 0.0),
            duration: 3.0,
            timingFunc: CAMediaTimingFunction(name: .easeInEaseOut),
            isRemovedOnCompletion: false))
        )

        animation.fillMode = .forwards
        animation.repeatCount = .infinity
        
        let id = Animation.KeyPath.self
        layer.add(animation, forKey: "\(id.revalAnimation)")
    }
    
    public func endAnimation() {
        let id = Animation.KeyPath.self
        layer.removeAnimation(forKey: "\(id.revalAnimation)")
    }
}

