import UIKit

final class MultichromeLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        _config()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        _config()
    }
    
    private func _config() {
        layer.contentsFormat = .RGBA8Uint
    }
}
