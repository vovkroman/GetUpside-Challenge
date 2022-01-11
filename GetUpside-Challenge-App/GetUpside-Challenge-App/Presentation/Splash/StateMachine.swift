import Foundation

extension Splash {
    final class StateMachine {
        
        enum State {
            case idle
            case loading
            case operating(coordinate: Coordinate)
            case error(viewModel: Splash.ViewModel)
        }
        
        enum Event {
            case authDidStarted
            case coordinateDidUpdated(Coordinate)
            case catchError(Splash.ViewModel)
        }
        
        private var _state: State = .idle {
            didSet {
                guard oldValue != _state else { return }
                observer?.stateDidChanched(
                    self,
                    to: _state
                )
            }
        }
        
        weak var observer: StateMachineObserver?
        
        func transition(with event: Event) {
            switch (_state, event) {
            case (.idle, .authDidStarted), (.operating, .authDidStarted), (.error, .authDidStarted):
                _state = .loading
            case (.idle, .coordinateDidUpdated(let coordinate)), (.error, .coordinateDidUpdated(let coordinate)):
                _state = .operating(coordinate: coordinate)
            case (.idle, .catchError(let viewModel)), (.loading, .catchError(let viewModel)), (.operating, .catchError(let viewModel)):
                _state = .error(viewModel: viewModel)
            case (.loading, .authDidStarted):
                break
            case (.loading, .coordinateDidUpdated(let coordinate)):
                _state = .operating(coordinate: coordinate)
            case (.operating(let old), .coordinateDidUpdated(let new)) where old != new:
                _state = .operating(coordinate: new)
            case (.operating, .coordinateDidUpdated):
                break
            case (.error(let old), .catchError(let new)) where old != new:
                _state = .error(viewModel: new)
            case (.error, .catchError):
                break
            }
        }
    }
}

extension Splash.StateMachine.State: Equatable {
    
    static func == (
        lhs: Splash.StateMachine.State,
        rhs: Splash.StateMachine.State
    ) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle),
             (.loading, .loading):
            return true
        case (.operating(let lhs), .operating(let rhs)):
            return lhs == rhs
        case (.error(let lhs), .error(let rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
}
