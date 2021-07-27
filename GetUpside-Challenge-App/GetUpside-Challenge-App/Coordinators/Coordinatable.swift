import UIKit
import Logger

protocol Coordinatable: AnyObject {
    func start(animated: Bool)
    func coordinate(to coordinator: Coordinatable, animated: Bool)
}

class BaseCoordinator: NSObject, Coordinatable {

    var children: ContiguousArray<Coordinatable> = []
    
    func addDependency(_ coordinator: Coordinatable) {
        children.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinatable?) {
        guard children.isEmpty == false,
            let coordinator = coordinator else { return }
        
        for (index, element) in children.enumerated() {
            if element === coordinator {
                children.remove(at: index)
                break
            }
        }
    }

    func start(animated: Bool = true) {
        // nothing should be done since, should be overrided
        // fatalError("'start' method should be overrided")
    }
    
    func coordinate(to coordinator: Coordinatable, animated: Bool) {
        coordinator.start(animated: animated)
    }
    
    deinit {
        Logger.debug("\(self) has been removed", category: .lifeCycle)
    }
}
