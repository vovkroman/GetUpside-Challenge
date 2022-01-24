import UIKit

extension Main {
    
    enum Event {}
    
    class Coordinator: BaseCoordinator {
        
        private let _navigationController: UINavigationController
        private let _appDependecies: AppDependencies
        private let _entities: [Eatery]
        weak var parentCoordinator: ApplicationCoordinator?
        
        // MARK: - Public methods
        
        override func start(animated: Bool) {
            _navigationController.isNavigationBarHidden = false
            let scene = _appDependecies.buildMainScene(AnyCoordinating(self), _entities)
            _navigationController.setViewControllers([scene], animated: animated)
        }
        
        init(_ navigationController: UINavigationController, _ appDependecies: AppDependencies, _ entities: [Eatery]) {
            _navigationController = navigationController
            _appDependecies = appDependecies
            _entities = entities
        }
    }
}

extension Main.Coordinator: Coordinating {
    
    typealias Event = Main.Event
    
    func cacthTheEvent(_ event: Event) {}
    
    func catchTheError(_ error: Error) {}
}
