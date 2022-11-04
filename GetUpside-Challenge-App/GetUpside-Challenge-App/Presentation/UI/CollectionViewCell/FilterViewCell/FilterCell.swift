import UI
import ReusableKit

final class FilterCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var _titleLabel: PillLabel!
    
    func configure(_ viewModel: Filter.ViewModelable) {
        _titleLabel.attributedText = viewModel.attributedString
    }
}
