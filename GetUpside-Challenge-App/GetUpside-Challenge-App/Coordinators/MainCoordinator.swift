import UIKit

extension Main {
    
    enum Event {
        
    }
    
    class Coordinator: BaseCoordinator {
        
        private let _navigationController: UINavigationController
        private let _appDependecies: AppDependencies
        weak var parentCoordinator: ApplicationCoordinator?
        
        // MARK: - Public methods
        
        override func start(animated: Bool) {
            _navigationController.isNavigationBarHidden = false
            let scene = _appDependecies.buildMainScene(AnyCoordinating(self))
            _navigationController.setViewControllers([scene], animated: animated)
        }
        
        init(_ navigationController: UINavigationController, _ appDependecies: AppDependencies) {
            _navigationController = navigationController
            _appDependecies = appDependecies
        }
    }
}

extension Main.Coordinator: Coordinating {
    
    typealias Event = Main.Event
    
    func cacthTheEvent(_ event: Event) {}
    
    func catchTheError(_ error: Error) {}
}
