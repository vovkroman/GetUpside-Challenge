import UIKit

public protocol LogoTransitionable: AnyObject {
    var maskLayer: CAShapeLayer? { get }
    func transitionWillStart(_ transition: UIViewControllerAnimatedTransitioning)
    func transitionDidEnd(_ transition: UIViewControllerAnimatedTransitioning)
}

public class RevealAnimator: NSObject {
    
    typealias Revealable = LogoTransitionable & UIView
    
    private let duartion: TimeInterval
        
    public init?(
        _ duration: TimeInterval,
        operation: UINavigationController.Operation) {
        // only push operation
        guard operation == .push else {
            return nil
        }
        self.duartion = duration
    }
    
    private func onTransitionComplete(
        with context: UIViewControllerContextTransitioning,
        toView: UIView,
        fromView: UIView) {
        context.completeTransition(!context.transitionWasCancelled)
        toView.layer.mask = nil
    }
}

extension RevealAnimator: UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?
    ) -> TimeInterval {
        return duartion
    }
    
    public func animateTransition(
        using transitionContext: UIViewControllerContextTransitioning
    ) {
        guard let fromView = transitionContext.view(forKey: .from) as? Revealable,
            let toView = transitionContext.view(forKey: .to),
            let maskLayer = fromView.maskLayer else {
                transitionContext.completeTransition(false)
                return
        }
        
        transitionContext.containerView.addSubview(toView)
        
        let animParams = Animation.Params(
            from: CATransform3DIdentity,
            to: CATransform3DConcat(CATransform3DMakeTranslation(10.0, 0.0, 0.0),
                                                                  CATransform3DMakeScale(150.0, 150.0, 1.0)),
            duration: duartion,
            timingFunc: CAMediaTimingFunction(name: .easeIn),
            isRemovedOnCompletion: false
        )
        let animation = CABasicAnimation(type: .transform(params: animParams))
        animation.fillMode = .forwards
        
        toView.layer.mask = maskLayer
        fromView.transitionWillStart(self)
        let completionBlock: () -> Void = { [weak self] in
            guard let self = self else { return }
            self.onTransitionComplete(with: transitionContext, toView: toView, fromView: fromView)
        }
        CATransaction.setCompletionBlock(completionBlock)
        CATransaction.begin()
        let id = Animation.KeyPath.self
        maskLayer.add(animation, forKey: "\(id.revalAnimation)")
        CATransaction.commit()
    }
}
