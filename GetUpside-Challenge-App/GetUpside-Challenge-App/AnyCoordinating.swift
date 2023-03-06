import Foundation

protocol Coordinating: AnyObject {
    associatedtype Event
    func cacthTheEvent(_ event: Event)
    func catchTheError(_ error: Error)
}

class AnyCoordinating<T>: Coordinating {
    
    typealias Event = T
    
    private let catchTheEvent: (Event) -> Void
    private let catchTheError: (Error) -> Void
    
    func cacthTheEvent(_ event: T) {
        catchTheEvent(event)
    }
    
    func catchTheError(_ error: Error) {
        catchTheError(error)
    }
    
    init<Coordinator: Coordinating>(_ coordinator: Coordinator) where Coordinator.Event == T {
        catchTheEvent = coordinator.cacthTheEvent
        catchTheError = coordinator.catchTheError
    }
}
