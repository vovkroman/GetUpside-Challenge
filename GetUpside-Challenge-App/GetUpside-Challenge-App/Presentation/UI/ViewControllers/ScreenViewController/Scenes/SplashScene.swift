import UI

extension Splash {
    
    final class Scene: BaseScene<SplashView, InteractorImpl> {
        
        private var containerView: ContainerView {
            return contentView.containerView
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setup()
            showAnimatingLogo()
        }
        
        // MARK: - Configurations
        
        private func setup() {
            containerView.parentViewController = self // I'm your father Luke
            interactor.requestLocation()
        }
        
        private func fetchData(by coordinate: Coordinates) {
            interactor.fetchingData(coordinate)
        }
        
        private func cancelFetching() {
            interactor.cancelFetching()
        }
    }
}

// Operating

private extension Splash.Scene {
    
    func showAnimatingLogo() {
        if let _ = containerView.childViewController as? LogoScene {
            return
        }
        let logoViewController = LogoScene()
        containerView.childViewController = logoViewController
    }
    
    func showError<ViewModel: ButtonTitlable & ActionaSupporting & Descriptionable>(_ viewModel: ViewModel) {
        let errorViewController = ErrorScene(viewModel)
        containerView.childViewController = errorViewController
    }
}

extension Splash.Scene: SplashPresentable {
    
    func onLoading() {
        showAnimatingLogo()
    }
    
    func onErrorDidCatch(_ viewModel: Splash.ViewModel) {
        showError(viewModel)
        cancelFetching()
    }
    
    func onLocationDidUpdate(_ coordinate: Coordinates) {
        showAnimatingLogo()
        fetchData(by: coordinate)
    }
}