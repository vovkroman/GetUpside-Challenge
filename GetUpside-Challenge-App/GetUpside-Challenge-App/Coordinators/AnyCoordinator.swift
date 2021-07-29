import Foundation

class AnyCoordinator<EventType>: CoordinatableProtocol {
    
    typealias Event = EventType
    
    private let _cacthTheEventClosure: (EventType) -> Void
    private let _catchTheErrorClosure: (Error) -> Void
    
    func cacthTheEvent(_ event: EventType) {
        _cacthTheEventClosure(event)
    }
    
    func catchTheError(_ error: Error) {
        _catchTheErrorClosure(error)
    }
    
    init<T: CoordinatableProtocol>(_ coordinator: T) where T.Event == EventType {
        _cacthTheEventClosure = coordinator.cacthTheEvent
        _catchTheErrorClosure = coordinator.catchTheError
    }
}
