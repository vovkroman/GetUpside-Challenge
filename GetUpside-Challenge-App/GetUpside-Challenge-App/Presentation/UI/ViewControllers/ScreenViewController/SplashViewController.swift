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
            contentView.showError(Location.Error.restricted)
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
    }
}

extension Splash.Scene: StateMachineObserver {
    func stateDidChanched(_ stateMachine: Splash.StateMachine, to: Splash.StateMachine.State) {
        switch to {
        case .idle, .loading:
            print("Loading....")
        case .error(let error):
            print("Got an error: \(error)")
            break
        case .operating(let coordinate):
            print("Got new coordinate: \(coordinate)")
            _fetchData(by: coordinate)
            break
        }
    }
}
