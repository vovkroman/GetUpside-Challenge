import UIKit
import Logger

protocol SplashFlowCoordinatable: AnyObject {
//    func itemsBeenHasLoaded(_ viewModel: Main.ViewModel)
    func catchTheError(_ error: Error)
}

extension Splash {
        
    class Coordinator: BaseCoordinator {
                
        private let _navigationController: UINavigationController
        weak var parentCoordinator: ApplicationCoordinator?
        
        // MARK: - Public methods
        
        override func start(animated: Bool) {
            let viewModel = ViewModel(coordinator: self)
            let viewController = ViewController(viewModel: viewModel)
            viewController.coordinator = self
            _navigationController.setViewControllers([viewController], animated: animated)
        }
        
        init(_ navigationController: UINavigationController) {
            _navigationController = navigationController
            super.init()
            _navigationController.delegate = self
        }
        
        // MARK: - Private methods
        
        private func _navigateToMainFlow(animated: Bool = true, viewModel: Main.ViewModel) {
            let mainCoordintaor = Main.Coordinator(_navigationController, viewModel: viewModel)
            mainCoordintaor.parentCoordinator = parentCoordinator
            parentCoordinator?.removeDependency(self)
            parentCoordinator?.addDependency(mainCoordintaor)
            coordinate(to: mainCoordintaor, animated: animated)
        }
    }
}

extension Splash.Coordinator: SplashFlowCoordinatable {
//    func itemsBeenHasLoaded(_ viewModel: Main.ViewModel) {
//        DispatchQueue.main.async {
//            //self._navigateToMainFlow(viewModel: viewModel)
//        }
//    }
    
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
      to toVC: UIViewController) ->
      UIViewControllerAnimatedTransitioning? {
        let durationType = Constant.Animator.self
        return RevealAnimator(durationType.duration, operation: operation)
    }
}
