import ReusableKit
import UIKit

final class ErrorViewController: BaseViewController<ErrorView> {
    
    typealias ViewModelable = ButtonTitlable & ActionaSupporting & Descriptionable
    
    private let _viewModel: ViewModelable
    
    // MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let actionButton: UIButton = contentView.actionButton
        
        if _viewModel.isEnabled {
            actionButton.addTarget(self, action: #selector(_onTapped(_:)), for: .touchUpInside)
            actionButton.setTitle(_viewModel.title, for: .normal)
        } else {
            actionButton.isHidden = true
        }
        contentView.descriptionLabel.text = _viewModel.description
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let actionButton: UIButton = contentView.actionButton
        
        actionButton.removeTarget(self, action: #selector(_onTapped(_:)), for: .touchUpInside)
        actionButton.setTitle(nil, for: .normal)
        
        contentView.descriptionLabel.text = nil
    }
    
    // MARK: - Initialization methods
    
    init<ViewModel: ButtonTitlable & ActionaSupporting & Descriptionable>(_ viewModel: ViewModel) {
        _viewModel = viewModel
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
    
    @objc private func _onTapped(_ sender: UIButton) {
        let _ = _viewModel.action?()
    }
}

extension ErrorViewController: LogoTransitionable {
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
