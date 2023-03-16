import UIKit

open class MultichromeLabel: UILabel {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialConfig()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initialConfig()
    }
    
    private func initialConfig() {
        layer.contentsFormat = .RGBA8Uint
    }
}
