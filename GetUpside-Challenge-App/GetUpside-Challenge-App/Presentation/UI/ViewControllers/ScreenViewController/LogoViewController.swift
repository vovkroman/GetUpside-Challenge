import Foundation

final class LogoViewController: BaseViewController<LogoView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.setupLogo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.startAnimating()
    }
}
