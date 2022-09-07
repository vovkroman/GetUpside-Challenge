import Foundation

protocol SplashStateMachineObserver: AnyObject {
    func stateDidChanched(_ stateMachine: Splash.StateMachine, to: Splash.StateMachine.State)
}

protocol LocationPresenting: AnyObject {
    func locationDidRequestForAuthorization()
    func locationDidUpdated(with coordinate: Coordinates)
    func locationCatch(the error: Location.Error)
}

extension Splash {
    
    final class Presenter {
        private var _stateMachine: StateMachine = StateMachine()
        private let _queue: DispatchQueue
        
        weak var observer: SplashStateMachineObserver? {
            didSet {
                _stateMachine.observer = observer
            }
        }
        
        init(_ queue: DispatchQueue) {
            _queue = queue
        }
    }
}

extension Splash.Presenter: LocationPresenting {
    func locationCatch(the error: Location.Error) {
        let viewModel = Splash.ViewModel(error)
        _queue.sync(execute: combine(.catchError(viewModel), with: _stateMachine.transition))
    }
    
    func locationDidUpdated(with coordinate: Coordinates) {
        _queue.sync(execute: combine(.coordinateDidUpdated(coordinate), with: _stateMachine.transition))
    }
    
    func locationDidRequestForAuthorization() {
        _queue.sync(execute: combine(.authDidStarted, with: _stateMachine.transition))
    }
}
