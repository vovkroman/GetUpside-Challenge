import UIKit

extension Splash {
    
    class ViewController: BaseViewController<SplashView, ViewModel> {
                
        weak var coordinator: SplashFlowCoordinatable?
        
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
            viewModel.load()
        }
        
        private func _setupLogo() {
            let type = Constant.TestView.self
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            
            let attrString = NSMutableAttributedString(string: "Get\n",
                                                attributes: [NSAttributedString.Key.font: type.font,
                                                             NSAttributedString.Key.paragraphStyle: paragraphStyle])
            attrString.append(NSAttributedString(string: "Upside",
                                                        attributes: [NSAttributedString.Key.font: type.font1,
                                                                     NSAttributedString.Key.paragraphStyle: paragraphStyle]))
            
            _testView.attributedString = attrString
        }
    }
}
