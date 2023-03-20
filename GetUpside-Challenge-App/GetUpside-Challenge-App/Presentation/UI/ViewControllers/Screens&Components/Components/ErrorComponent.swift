import ReusableKit
import UIKit
import UI

final class ErrorComponent: BaseComponent<ErrorView> {
    
    typealias ViewModelable = ButtonTitlable & ActionaSupporting & Descriptionable
    
    private let viewModel: ViewModelable
    
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let actionButton: UIButton = contentView.actionButton
        
        if viewModel.isEnabled {
            actionButton.addTarget(self, action: #selector(onTapped(_:)), for: .touchUpInside)
            actionButton.setTitle(viewModel.title, for: .normal)
        } else {
            actionButton.isHidden = true
        }
        contentView.descriptionLabel.text = viewModel.description
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let actionButton: UIButton = contentView.actionButton
        
        actionButton.removeTarget(self, action: #selector(onTapped(_:)), for: .touchUpInside)
        actionButton.setTitle(nil, for: .normal)
        
        contentView.descriptionLabel.text = nil
    }
    
    // MARK: - Initialization methods
    
    init<ViewModel: ButtonTitlable & ActionaSupporting & Descriptionable>(_ viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    @available(*, unavailable)
    required init() {
        fatalError("init() has not been implemented")
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    @objc private func onTapped(_ sender: UIButton) {
        let _ = viewModel.action?()
    }
}

extension ErrorComponent: MaskTransitionable {
    var maskLayer: CAShapeLayer? {
        return nil
    }
    
    func transitionWillStart(_ transition: UIViewControllerAnimatedTransitioning) {
        // Nothing to do
    }
    
    func transitionDidEnd(_ transition: UIViewControllerAnimatedTransitioning) {
        contentView.removeFromSuperview()
    }
}
