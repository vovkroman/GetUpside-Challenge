import ReusableKit

final class SplashView: UIView, NibReusable {
    @IBOutlet private(set) weak var containerView: ContainerView!
    
    private var _currentViewController: LogoTransitionable? {
        return containerView.childViewController as? LogoTransitionable
    }
}

extension SplashView: LogoTransitionable {
    
    var maskLayer: CAShapeLayer? {
        return _currentViewController?.maskLayer
    }
    
    func transitionWillStart(_ transition: UIViewControllerAnimatedTransitioning) {
        _currentViewController?.transitionWillStart(transition)
    }
    
    func transitionDidEnd(_ transition: UIViewControllerAnimatedTransitioning) {
        _currentViewController?.transitionDidEnd(transition)
    }
}
