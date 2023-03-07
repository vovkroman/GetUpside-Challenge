import UI
import ReusableKit

final class FilterCell: UICollectionViewCell, NibReusable, Cellable {
    
    @IBOutlet private weak var titleLabel: PillLabel!
    
    weak var borderLayer: CAShapeLayer?
    
    override var isSelected: Bool {
        didSet {
            guard oldValue != isSelected else { return }
            titleLabel.isSelected = isSelected
        }
    }
    
    func configure(_ configurator: Filter.CellConfigurator) {
        titleLabel.attributedText = configurator.attributedString
        isSelected = configurator.isSelected
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        isSelected = false
    }
}
