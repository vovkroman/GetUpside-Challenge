import UIKit
import Logger

protocol CoordinatableProtocol: AnyObject {
    associatedtype Event
    func cacthTheEvent(_ event: Event)
    func catchTheError(_ error: Error)
}

protocol SplashViewControllerFactory: AnyObject {
    func makeController(_ coordinator: Splash.Coordinator) -> UIViewController
}

extension Splash {
    
    enum Event {}
    
    class Coordinator: BaseCoordinator {
        typealias Factory = SplashViewControllerFactory

        private let _navigationController: UINavigationController
        private let _factory: Factory
        
        weak var parentCoordinator: ApplicationCoordinator?
        
        // MARK: - Public methods
        override func start(animated: Bool) {
            let viewController = _factory.makeController(self)
            _navigationController.setViewControllers([viewController], animated: animated)
        }
        
        init(_ navigationController: UINavigationController, factory: Factory) {
            _navigationController = navigationController
            _factory = factory
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

extension Splash.Coordinator: CoordinatableProtocol {
    typealias Event = Splash.Event
    
    func cacthTheEvent(_ event: Splash.Event) {
        // handle event
    }
    
    func catchTheError(_ error: Error) {
        //handle error
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
        return RevealAnimator(durationType.duration, operation: operation)
    }
}
