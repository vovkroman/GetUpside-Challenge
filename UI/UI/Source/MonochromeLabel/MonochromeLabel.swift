import UIKit

open class MonochromeLabel: UILabel {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        _config()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        _config()
    }
    
    private func _config() {
        layer.contentsFormat = .gray8Uint
    }
}