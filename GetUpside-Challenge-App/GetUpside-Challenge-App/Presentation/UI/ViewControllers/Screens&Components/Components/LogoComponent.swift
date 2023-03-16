import UI

final class LogoComponent: BaseComponent<GetUpsideLogoView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.setupLogo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.startAnimating()
    }
}

extension LogoComponent: LogoTransitionable {

    var maskLayer: CAShapeLayer? {
        let shapelayer = CAShapeLayer()
        shapelayer.isGeometryFlipped = true
        shapelayer.frame = contentView.frame
        shapelayer.path = contentView.layer.path
        return shapelayer
    }
    
    func transitionWillStart(_ transition: UIViewControllerAnimatedTransitioning) {
        contentView.layer.removeAllAnimations()
        
        // to remove border path (should be done after toView set the path)
        contentView.layer.path = nil
    }
    
    func transitionDidEnd(_ transition: UIViewControllerAnimatedTransitioning) {
        contentView.removeFromSuperview()
    }
}
