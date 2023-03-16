import UIKit

extension Main {
    
    enum Event {}
    
    class Coordinator: BaseCoordinator {
        
        private let navigationController: UINavigationController
        private let appDependecies: AppDependencies
        private let entities: [Eatery]
        weak var parentCoordinator: ApplicationCoordinator?
        
        // MARK: - Public methods
        
        override func start(animated: Bool) {
            let scene = appDependecies.buildMainScene(AnyCoordinating(self), entities)
            navigationController.setViewControllers([scene], animated: animated)
        }
        
        init(_ navigationController: UINavigationController, _ appDependecies: AppDependencies, _ entities: [Eatery]) {
            self.navigationController = navigationController
            self.appDependecies = appDependecies
            self.entities = entities
        }
    }
}

extension Main.Coordinator: Coordinating {
    
    typealias Event = Main.Event
    
    func cacthTheEvent(_ event: Event) {}
    
    func catchTheError(_ error: Error) {}
}
