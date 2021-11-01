import Foundation

final class LogoView: LetteringView {
    
    private func _setupLogo() {
        let type = Constant.SplashLogo.self
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        // creating attributes is very resource consumed,makes sense to crate static attributes
        let attrString = NSAttributedString.composing {
            NSAttributedString(string: "Get\n",
                               attributes: [NSAttributedString.Key.font: type.title,
                                            NSAttributedString.Key.paragraphStyle: paragraphStyle])
            NSAttributedString(string: "Upside\n",
                               attributes: [NSAttributedString.Key.font: type.header,
                                           NSAttributedString.Key.paragraphStyle: paragraphStyle])
            NSAttributedString(string: "Challenge",
                               attributes: [NSAttributedString.Key.font: type.body,
                                            NSAttributedString.Key.paragraphStyle: paragraphStyle])
        }
        
        attributedString = attrString
    }
}

extension LogoView: SplashableView {
    func tapAction() {
        /* Nothing to do */
    }
    
    func setup() {
        _setupLogo()
    }
    
    func start() {
        startAnimating()
    }
}
