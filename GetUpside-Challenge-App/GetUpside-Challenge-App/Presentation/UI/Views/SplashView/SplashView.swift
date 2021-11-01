import UIKit

final class SplashView: UIView, NibReusable {
    
    @IBOutlet private weak var _containerView: SplashContainerView!
    
    func showLoading() {
        let view = LogoView()
        _containerView.addSubview(view)
    }
    
    func showError(_ error: Error) {
        let view = ErrorView("\(error)")
        _containerView.addSubview(view)
    }
}

extension SplashView: SplashableView {
    func tapAction() {
        _containerView.child?.tapAction()
    }
    
    func setup() {
        _containerView.child?.setup()
    }
    
    func start() {
        _containerView.child?.start()
    }
}
