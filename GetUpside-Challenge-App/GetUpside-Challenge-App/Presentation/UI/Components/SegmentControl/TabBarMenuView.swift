import ReusableKit

protocol TabBarMenuDelegate: AnyObject {
    func tabBarMenu(_ menu: TabBarMenuView, didSelected index: Int)
}

final class TabBarMenuView: UIView, NibOwnerLoadable {
    
    struct Options {
        enum State: Int {
            case selected
            case normal
        }
        
        let titleAttributes: [State: [NSAttributedString.Key : Any]] = [.normal: [:], .selected: [:]]
        let selectorColor: UIColor = .black
        let backgroundColor: UIColor = .white
    }
    
    @IBOutlet private weak var _segmentControl: UISegmentedControl!
    private weak var _selectorView: UIView!
    
    weak var delegate: TabBarMenuDelegate?
    
    let options: Options = Options()
    
    // MARK: - UIView Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
        _setupSelector()
        _removeAllTabs()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
        _setupSelector()
        _removeAllTabs()
    }
    
    // MARK: - Public API
    
    func updateLayout() {
        let newOrigin = (_segmentControl.frame.width / CGFloat(_segmentControl.numberOfSegments)) * CGFloat(_segmentControl.selectedSegmentIndex)
        UIView.animate(withDuration: 0.23) {
            self._selectorView.frame.origin.x = newOrigin
        } completion: { _ in }
    }
    
    func addTabItem(with title: String?, at index: Int, animated: Bool = true) {
        _segmentControl.insertSegment(withTitle: title, at: index, animated: animated)
    }
    
    func selectTab(at index: Int) {
        _segmentControl.selectedSegmentIndex = index
    }
    
    // MARK: - Setup methods
        
    private func _setupSelector() {
        let selectorView = UIView()
        selectorView.backgroundColor = options.selectorColor
        selectorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(selectorView)
        NSLayoutConstraint.activate([
            selectorView.leadingAnchor.constraint(equalTo: _segmentControl.leadingAnchor),
            selectorView.topAnchor.constraint(equalTo: _segmentControl.bottomAnchor, constant: 8.0),
            selectorView.widthAnchor.constraint(equalTo: _segmentControl.widthAnchor, multiplier: 1.0 / CGFloat(_segmentControl.numberOfSegments)),
            selectorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            selectorView.heightAnchor.constraint(equalToConstant: 2.0)
        ])
        _selectorView = selectorView
    }
    
    private func _removeAllTabs() {
        _segmentControl.removeAllSegments()
    }
    
    private func _configureSegemntContol() {
        
        let backgroundColor = options.backgroundColor.imageWithColor(CGSize(width: _segmentControl.bounds.width,
                                                                            height: _segmentControl.bounds.height))
        
        _segmentControl.setBackgroundImage(backgroundColor, for: .normal, barMetrics: .default)
        _segmentControl.setBackgroundImage(backgroundColor, for: .selected, barMetrics: .default)
        
        _segmentControl.setTitleTextAttributes(options.titleAttributes[.normal], for: .normal)
        _segmentControl.setTitleTextAttributes(options.titleAttributes[.selected], for: .selected)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _configureSegemntContol()
    }
    
    @IBAction private func _didTapAction(_ sender: UISegmentedControl) {
        let newOrigin = (sender.frame.width / CGFloat(sender.numberOfSegments)) * CGFloat(sender.selectedSegmentIndex)
        self.delegate?.tabBarMenu(self, didSelected: sender.numberOfSegments - sender.selectedSegmentIndex - 1)
        UIView.animate(withDuration: 0.23) {
            self._selectorView.frame.origin.x = newOrigin
        } completion: { _ in }
    }
}
