import ReusableKit

final class ErrorView: UIView, NibReusable {
    
    @IBOutlet private(set) weak var descriptionLabel: UILabel!
    @IBOutlet private(set) weak var actionButton: BorderedButton!
    
    // MARK: Create view from xib
    
    // MARK: - Actions
    @IBAction private func didTapButton(_ sender: UIButton) {
        print("Tap the action")
    }
}
