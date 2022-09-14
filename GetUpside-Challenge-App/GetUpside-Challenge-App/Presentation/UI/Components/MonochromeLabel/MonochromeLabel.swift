import UIKit

class MonochromeLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _config()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        _config()
    }
    
    private func _config() {
        layer.contentsFormat = .gray8Uint
    }
}
