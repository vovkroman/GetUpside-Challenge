import UIKit
import Logger

extension Splash {
    typealias Entity = Eatery
    enum Event {
        case items([Entity])
    }
    
    class Coordinator: BaseCoordinator {
        private let _navigationController: UINavigationController
        private let _appDependecies: AppDependencies
        
        weak var parentCoordinator: ApplicationCoordinator?
        
        // MARK: - Public methods
        override func start(animated: Bool) {
            
            let builder = SplashScreenBuilder(_appDependecies)
            builder.coordinator = self
            
            let scene = builder.makeScene()
            _navigationController.setViewControllers([scene], animated: animated)
        }
        
        init(
            _ navigationController: UINavigationController,
             appDependecies: AppDependencies
        ) {
            _navigationController = navigationController
            _appDependecies = appDependecies
            super.init()
            _navigationController.delegate = self
        }
        
        // MARK: - Private methods
        
//        private func _navigateToMainFlow(animated: Bool = true, viewModel: Main.ViewModel) {
////            let mainCoordintaor = Main.Coordinator(_navigationController, viewModel: viewModel)
////            mainCoordintaor.parentCoordinator = parentCoordinator
////            parentCoordinator?.removeDependency(self)
////            parentCoordinator?.addDependency(mainCoordintaor)
////            coordinate(to: mainCoordintaor, animated: animated)
//        }
    }
}

extension Splash.Coordinator: Coordinating {
    typealias Event = Splash.Event
    
    func cacthTheEvent(_ event: Event) {
        print(event)
    }
    
    func catchTheError(_ error: Error) {
        print(error.localizedDescription)
    }
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
