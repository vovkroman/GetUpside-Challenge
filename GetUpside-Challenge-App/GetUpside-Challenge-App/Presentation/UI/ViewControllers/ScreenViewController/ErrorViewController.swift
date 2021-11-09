import ReusableKit

final class ErrorViewController: BaseViewController<ErrorView> {
    
    private let _description: String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.descriptionLabel.text = _description
    }
    
    init(_ description: String) {
        _description = description
        super.init()
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ErrorViewController: LogoTransitionable {
    var maskLayer: CAShapeLayer? {
        return nil
    }
    
    func transitionWillStart(_ transition: UIViewControllerAnimatedTransitioning) {
        // Nothing to do
    }
    
    func transitionDidEnd(_ transition: UIViewControllerAnimatedTransitioning) {
        contentView.removeFromSuperview()
    }
}
