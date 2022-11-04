import ReusableKit
import UI

final class ErrorView: UIView, NibReusable {
    @IBOutlet private(set) weak var descriptionLabel: UILabel!
    @IBOutlet private(set) weak var actionButton: BorderedButton!
}
