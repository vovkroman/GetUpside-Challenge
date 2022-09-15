import UIKit

protocol Animatable: AnyObject {
    func startAnimation()
    func endAnimation()
}

final class PinIconView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PinIconView: Animatable {
    
    func startAnimation() {
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
    
    func endAnimation() {
        let id = Animation.KeyPath.self
        layer.removeAnimation(forKey: "\(id.revalAnimation)")
    }
}

