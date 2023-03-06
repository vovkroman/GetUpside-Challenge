import UI
import ReusableKit

final class GetUpsideLogoView: LogoView, NibReusable {
    
    func setupLogo() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let type = Constant.SplashLogo.self
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
        setLogo(attrString)
    }
}
