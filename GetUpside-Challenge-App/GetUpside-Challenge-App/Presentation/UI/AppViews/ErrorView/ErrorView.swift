import UIKit
import ReusableKit

final class ErrorView: UIView, NibReusable {
    @IBOutlet private(set) weak var descriptionLabel: UILabel!
    @IBOutlet private(set) weak var actionButton: ErrordButton!
}
