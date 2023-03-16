import UI
import Logger

extension Splash {
    typealias Event = [Eatery]
    
    final class Coordinator: BaseCoordinator {
        private let navigationController: UINavigationController
        private let appDependecies: AppDependencies
        
        weak var parentCoordinator: ApplicationCoordinator?
        
        // MARK: - Public methods
        override func start(animated: Bool) {
            let scene = appDependecies.buildSplashScene(AnyCoordinating(self))
            navigationController.setViewControllers([scene], animated: animated)
        }
        
        init(
            _ navigationController: UINavigationController,
             appDependecies: AppDependencies
        ) {
            self.navigationController = navigationController
            self.appDependecies = appDependecies
            super.init()
            self.navigationController.delegate = self
        }
        
        // MARK: - Private API
        
        private func navigateToMainFlow(animated: Bool = true, _ entities: [Eatery]) {
            let mainCoordintaor = Main.Coordinator(navigationController, appDependecies, entities)
            mainCoordintaor.parentCoordinator = parentCoordinator
            parentCoordinator?.removeDependency(self)
            parentCoordinator?.addDependency(mainCoordintaor)
            coordinate(to: mainCoordintaor, animated: animated)
        }
    }
}

extension Splash.Coordinator: Coordinating {
    typealias Event = [Eatery]
    
    func cacthTheEvent(_ event: Event) {
        DispatchQueue.main.async(execute: combine(true, event, with: navigateToMainFlow))
    }
    
    func catchTheError(_ error: Error) {}
}

extension Splash.Coordinator: UINavigationControllerDelegate {
    func navigationController(_
      navigationController: UINavigationController,
      animationControllerFor
      operation: UINavigationController.Operation,
      from fromVC: UIViewController,
      to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        let durationType = Constant.Animator.self
        return RevealAnimator(
            durationType.duration,
            operation: operation
        )
    }
}
