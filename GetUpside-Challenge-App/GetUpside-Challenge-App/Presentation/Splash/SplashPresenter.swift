import Foundation

protocol StateMachineObserver: AnyObject {
    func stateDidChanched(_ stateMachine: Splash.StateMachine, to: Splash.StateMachine.State)
}

protocol SplashPresentable: AnyObject {
    func locationDidRequestForAuthorization()
    func locationDidUpdated(with coordinate: Coordinate)
    func locationCatch(the error: Error)
}

extension Splash {
    
    final class Presenter {
        private var _stateMachine: StateMachine = StateMachine()
        private let _queue: DispatchQueue
        
        weak var observer: StateMachineObserver? {
            didSet {
                _stateMachine.observer = observer
            }
        }
        
        init(_ queue: DispatchQueue) {
            _queue = queue
        }
    }
}

extension Splash.Presenter: SplashPresentable {
    func locationCatch(the error: Error) {
        
    }
    
    func locationDidUpdated(with coordinate: Coordinate) {
        
    }
    
    func locationDidRequestForAuthorization() {
        
    }
}
