import ReusableKit

final class EateryTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak private var _titleLabel: MonochromeLabel!
    @IBOutlet weak private var _typeLabel: PillLabel!
    
    func configure(_ viewModel: Namable) {
        _titleLabel.text = viewModel.name
    }
}
