import UIKit

protocol SplashableView: UIView {
    func setup()
    func start()
    func tapAction()
}

extension Splash {
    
    class Scene: BaseScene<SplashView, InteractorImpl> {
        
        override func viewDidLoad() {
            super.viewDidLoad()
            _initialSetup()
            contentView.showLoading()
            contentView.setup()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            contentView.start()
        }
        
        // MARK: - Configurations
        
        private func _initialSetup() {
            interactor.requestLocation()
        }
        
        private func _fetchData(by coordinate: Coordinate) {
            interactor.fetachData(Splash.Request(coordinates: coordinate))
        }
        
        // MARK: - Operating
        
        private func _handleState(_ state: Splash.StateMachine.State) {
            switch state {
            case .idle, .loading:
                contentView.showLoading()
            case .error(let error):
                contentView.showError(error)
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
