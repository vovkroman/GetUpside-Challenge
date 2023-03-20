import ReusableKit
import UI

final class SplashView: UIView, NibReusable {
    @IBOutlet private(set) weak var containerView: ContainerView!
    
    private var currentViewController: MaskTransitionable? {
        return containerView.childViewController as? MaskTransitionable
    }
}

extension SplashView: MaskTransitionable {
    
    var maskLayer: CAShapeLayer? {
        return currentViewController?.maskLayer
    }
    
    func transitionWillStart(_ transition: UIViewControllerAnimatedTransitioning) {
        currentViewController?.transitionWillStart(transition)
    }
    
    func transitionDidEnd(_ transition: UIViewControllerAnimatedTransitioning) {
        currentViewController?.transitionDidEnd(transition)
    }
}
