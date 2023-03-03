import UIKit

open class MonochromeLabel: UILabel {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        config()
    }
    
    private func config() {
        layer.contentsFormat = .gray8Uint
    }
}
