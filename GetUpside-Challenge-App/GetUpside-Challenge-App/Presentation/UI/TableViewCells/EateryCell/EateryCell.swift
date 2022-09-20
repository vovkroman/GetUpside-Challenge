import ReusableKit

final class EateryCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak private var _titleLabel: MonochromeLabel!
    @IBOutlet weak private var _typeLabel: PillLabel!
    
    func configure(_ viewModel: Main.ViewModelable) {
        _titleLabel.text = viewModel.name
        _typeLabel.text = viewModel.type
    }
}
