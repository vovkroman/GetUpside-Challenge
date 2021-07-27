import UIKit

protocol LogoTransitionable {
    var maskLayer: CAShapeLayer { get }
    func transitionWillStart(_ transition: UIViewControllerAnimatedTransitioning)
    func transitionDidEnd(_ transition: UIViewControllerAnimatedTransitioning)
}

class RevealAnimator: NSObject {
    
    typealias Revealable = LogoTransitionable & UIView
    
    private let _duartion: TimeInterval
        
    init?(_ duration: TimeInterval, operation: UINavigationController.Operation) {
        // only push operation
        guard operation == .push else {
            return nil
        }
        _duartion = duration
    }
    
    private func onTransitionComplete(with context: UIViewControllerContextTransitioning, toView: UIView, fromView: UIView) {
        context.completeTransition(!context.transitionWasCancelled)
        toView.layer.mask = nil
    }
}

extension RevealAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return _duartion
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) as? Revealable,
            let toView = transitionContext.view(forKey: .to) else {
                transitionContext.completeTransition(false)
                return
        }
        
        transitionContext.containerView.addSubview(toView)
        
        let animParams = Animation.Params(from: CATransform3DIdentity,
                                          to: CATransform3DConcat(CATransform3DMakeTranslation(0.0, -10.0, 0.0),
                                                                  CATransform3DMakeScale(100.0, 100.0, 1.0)),
                                          duration: _duartion,
                                          timingFunc: CAMediaTimingFunction(name: .easeIn),
                                          isRemovedOnCompletion: false)
        let _animation = CABasicAnimation(type: .transform(params: animParams))
        _animation.fillMode = .forwards
        
        let maskLayer = fromView.maskLayer
        toView.layer.mask = maskLayer
        fromView.transitionWillStart(self)
        CATransaction.setCompletionBlock(combine(transitionContext, toView, fromView,  with: onTransitionComplete))
        CATransaction.begin()
        let id = Animation.KeyPath.self
        maskLayer.add(_animation, forKey: "\(id.revalAnimation)")
        CATransaction.commit()
    }
}
