import ReusableKit
import UIKit

final class SquareSegmentControl: UISegmentedControl {
    public override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 0
    }
}

protocol TabBarMenuDelegate: AnyObject {
    func tabBarMenu(_ menu: TabBarMenuView, didSelected index: Int)
}

final class TabBarMenuView: UIView, NibOwnerLoadable {
    
    struct Options {
        enum State: Int {
            case selected
            case normal
        }
        
        let titleAttributes: [State: [NSAttributedString.Key : Any]] = [.normal: [.font : UIFont.systemFont(ofSize: 14.0),
                                                                                  .foregroundColor: UIColor.black],
                                                                            .selected: [.font : UIFont.systemFont(ofSize: 15.0),
                                                                                        .foregroundColor: UIColor.black]]
        let selectorColor: UIColor = .black
        let backgroundColor: UIColor = .white
    }
    
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    private weak var selectorView: UIView!
    
    weak var delegate: TabBarMenuDelegate?
    
    let options: Options = Options()
    
    // MARK: - UIView Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
        setupSelector()
        removeAllTabs()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
        setupSelector()
        removeAllTabs()
    }
    
    // MARK: - Public API
    
    func updateLayout() {
        let newOrigin = (segmentControl.frame.width / CGFloat(segmentControl.numberOfSegments)) * CGFloat(segmentControl.selectedSegmentIndex)
        UIView.animate(withDuration: 0.23) {
            self.selectorView.frame.origin.x = newOrigin
        } completion: { _ in }
    }
    
    func addTabItem(with title: String?, at index: Int, animated: Bool = true) {
        segmentControl.insertSegment(withTitle: title, at: index, animated: animated)
    }
    
    func selectTab(at index: Int) {
        segmentControl.selectedSegmentIndex = index
    }
    
    // MARK: - Setup methods
        
    private func setupSelector() {
        let selectorView = UIView()
        selectorView.backgroundColor = options.selectorColor
        
        selectorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(selectorView)
        NSLayoutConstraint.activate([
            selectorView.leadingAnchor.constraint(equalTo: segmentControl.leadingAnchor),
            selectorView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 8.0),
            selectorView.widthAnchor.constraint(equalTo: segmentControl.widthAnchor, multiplier: 1.0 / CGFloat(segmentControl.numberOfSegments)),
            selectorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            selectorView.heightAnchor.constraint(equalToConstant: 2.0)
        ])
        self.selectorView = selectorView
    }
    
    private func removeAllTabs() {
        segmentControl.removeAllSegments()
    }
    
    private func configureSegemntContol() {
        
        let backgroundColor = options.backgroundColor.imageWithColor(CGSize(width: segmentControl.bounds.width,
                                                                            height: segmentControl.bounds.height))
        
        segmentControl.setBackgroundImage(backgroundColor, for: .normal, barMetrics: .default)
        segmentControl.setBackgroundImage(backgroundColor, for: .selected, barMetrics: .default)
        
        segmentControl.setTitleTextAttributes(options.titleAttributes[.normal], for: .normal)
        segmentControl.setTitleTextAttributes(options.titleAttributes[.selected], for: .selected)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureSegemntContol()
    }
    
    @IBAction private func didTapAction(_ sender: UISegmentedControl) {
        let newOrigin = (sender.frame.width / CGFloat(sender.numberOfSegments)) * CGFloat(sender.selectedSegmentIndex)
        self.delegate?.tabBarMenu(self, didSelected: sender.numberOfSegments - sender.selectedSegmentIndex - 1)
        UIView.animate(withDuration: 0.23) {
            self.selectorView.frame.origin.x = newOrigin
        } completion: { _ in }
    }
}
