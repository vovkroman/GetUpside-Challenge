import Foundation

final class ErrorView: UIView, NibReusable {
    
    @IBOutlet weak var _descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFromNib()
    }
    
    override var intrinsicContentSize: CGSize {
        
    }
    
    // Actions
    @IBAction private func didTapButton(_ sender: UIButton) {
        
    }
}

extension ErrorView: SplashableView {
    func setup() {}
    
    func start() {}
    
    func tapAction() {
        ////
    }
}
