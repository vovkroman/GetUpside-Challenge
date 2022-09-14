import UIKit

protocol HandleLinkDelegate: AnyObject {
    func label(_ label: LinkableLabel, didHandle link: URL)
}

final class LinkableLabel: UILabel {
    
    weak var delegate: HandleLinkDelegate?
    
    override var attributedText: NSAttributedString? {
        didSet {
            if let newValue = attributedText {
                _buildTextGraph(newValue)
            }
        }
    }
    
    // MARK: - Private API
    
    private func _initialSetup() {
        isUserInteractionEnabled = true
    }
    
    private func _configGetureReconizer() {
        let gestureRecognizer = UIGestureRecognizer(target: self, action: #selector(_onTapped(_:)))
        addGestureRecognizer(gestureRecognizer)
    }
    
    private func _buildTextGraph(_ attributedString: NSAttributedString) {
        let layoutManager: NSLayoutManager = NSLayoutManager()
        let textContainer: NSTextContainer = NSTextContainer(size: .zero)
        let textStorage: NSTextStorage = NSTextStorage(attributedString: attributedString)
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = lineBreakMode
        textContainer.maximumNumberOfLines = numberOfLines
    }
    
    // MARK: - Gesture Handler
    
    @objc private func _onTapped(_ recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: self)
        print("Location: \(location)")
    }
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        _initialSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        _initialSetup()
    }
}
