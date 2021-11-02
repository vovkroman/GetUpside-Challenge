import ReusableKit

final class ErrorView: UIView, NibOwnerLoadable {
    
    @IBOutlet private weak var _descriptionLabel: UILabel!
    @IBOutlet private weak var _actionButton: BorderedButton!
    
    convenience
    init(_ errorDescription: String) {
        self.init(frame: CGRect(x: 0.0, y: 0.0, width: 200.0, height: 200.0))
        _descriptionLabel.text = errorDescription
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }
    
    // MARK: Create view from xib
    
    // MARK: - Actions
    @IBAction private func didTapButton(_ sender: UIButton) {
        print("Tap the action")
    }
}
