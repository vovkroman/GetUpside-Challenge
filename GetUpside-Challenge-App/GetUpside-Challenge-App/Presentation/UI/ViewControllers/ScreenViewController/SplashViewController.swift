import UIKit

extension Splash {
    
    class ViewController: BaseViewController<SplashView, InteractorImpl> {
                        
        private var _testView: LetteringView {
            return contentView._testView
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            _setupLogo()
            _initialSetup()
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            _testView.updateView()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            _testView.start()
        }
        
        // MARK: - Configurations
        
        private func _initialSetup() {
            interactor.fetchTheData()
        }
        
        private func _setupLogo() {
            let type = Constant.SplashLogo.self
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
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
            
            _testView.attributedString = attrString
        }
    }
}
