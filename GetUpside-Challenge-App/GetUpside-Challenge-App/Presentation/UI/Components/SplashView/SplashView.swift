import UIKit
import ReusableKit

final class SplashView: UIView, NibReusable {
    
    @IBOutlet private weak var _containerView: ContainerView!
    
    func showLoading() {
        let view = LogoView()
        _containerView.removePreviousView()
        _containerView.insertSubview(view)
        view.setupLogo()
    }
    
    func showError(_ error: Error) {
        let view = ErrorView("\(error)")
        _containerView.removePreviousView()
        _containerView.insertSubview(view)
    }
}
