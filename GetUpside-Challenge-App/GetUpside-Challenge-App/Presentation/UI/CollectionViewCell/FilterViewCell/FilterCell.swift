import UI
import ReusableKit

final class FilterCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var titleLabel: PillLabel!
    
    weak var borderLayer: CAShapeLayer?
    
    override var isSelected: Bool {
        didSet {
            guard oldValue != isSelected else { return }
            titleLabel.isSelected = isSelected
        }
    }
    
    func configure(_ viewModel: Filter.ViewModelable) {
        titleLabel.attributedText = viewModel.attributedString
        isSelected = viewModel.isSelected
    }
}
