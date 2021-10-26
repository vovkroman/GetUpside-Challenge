import Foundation

protocol StateMachineObserver: AnyObject {
    func stateDidChanched(_ stateMachine: Splash.StateMachine, to: Splash.StateMachine.State)
}

protocol SplashPresentable: AnyObject {
    func locationDidRequestForAuthorization()
    func locationDidUpdated(with coordinate: Coordinate)
    func locationCatch(the error: Location.Error)
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
    func locationCatch(the error: Location.Error) {
        _queue.async(execute: combine(.catchError(error), with: _stateMachine.transition))
    }
    
    func locationDidUpdated(with coordinate: Coordinate) {
        _queue.async(execute: combine(.coordinateDidUpdated(coordinate), with: _stateMachine.transition))
    }
    
    func locationDidRequestForAuthorization() {
        _queue.async(execute: combine(.authDidStarted, with: _stateMachine.transition))
    }
}
