import UIKit

extension Splash {
    
    final class Scene: BaseScene<SplashView, InteractorImpl> {
        
        private var _containerView: ContainerView {
            return contentView.containerView
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            _initialSetup()
            _showLogo()
        }
        
        // MARK: - Configurations
        
        private func _initialSetup() {
            _containerView.parentViewController = self // I'm your father Luke
            interactor.requestLocation()
        }
        
        private func _fetchData(by coordinate: Coordinate) {
            interactor.fetachData(Splash.Request(coordinates: coordinate))
        }
        
        // MARK: - State handling
        private func _handleState(_ state: Splash.StateMachine.State) {
            switch state {
            case .idle, .loading:
                _showLogo()
            case .error(let error):
                _showError(error)
            case .operating(let coordinate):
                print("Got new coordinate: \(coordinate)")
                _fetchData(by: coordinate)
                break
            }
        }
    }
}

extension Splash.Scene: StateMachineObserver {
    func stateDidChanched(_ stateMachine: Splash.StateMachine, to: Splash.StateMachine.State) {
        DispatchQueue.main.async(execute: combine(to, with: _handleState))
    }
}

// Operating
private extension Splash.Scene {
    func _showLogo() {
        if let _ = _containerView.childViewController as? LogoViewController {
            return
        }
        let logoViewController = LogoViewController()
        _containerView.childViewController = logoViewController
    }
    
    func _showError(_ error: Error) {
        let errorViewController = ErrorViewController(error.localizedDescription)
        _containerView.childViewController = errorViewController
    }
}
