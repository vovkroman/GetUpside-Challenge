import UIKit
import ReusableKit

final class FilterHeaderView: UICollectionReusableView, NibReusable {
    
    @IBOutlet weak private var titleLabel: PillLabel!
    
    func configure(_ configurator: Filter.HeaderConfigurator) {
        titleLabel.attributedText = configurator.attributedString
    }
}
