import Foundation

extension Splash {
    final class StateMachine {
        
        enum State {
            case idle
            case loading
            case locating(coordinate: Coordinates)
            case error(error: Location.Error)
        }
        
        enum Event {
            case authDidStarted
            case coordinateDidUpdated(Coordinates)
            case catchError(Location.Error)
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
        
        weak var observer: SplashStateMachineObserver?
        
        func transition(with event: Event) {
            switch (_state, event) {
            case (.idle, .authDidStarted), (.locating, .authDidStarted), (.error, .authDidStarted):
                _state = .loading
            case (.idle, .coordinateDidUpdated(let coordinate)), (.error, .coordinateDidUpdated(let coordinate)):
                _state = .locating(coordinate: coordinate)
            case (.idle, .catchError(let error)), (.loading, .catchError(let error)), (.locating, .catchError(let error)):
                _state = .error(error: error)
            case (.loading, .authDidStarted):
                break
            case (.loading, .coordinateDidUpdated(let coordinate)):
                _state = .locating(coordinate: coordinate)
            case (.locating(let old), .coordinateDidUpdated(let new)) where old != new:
                _state = .locating(coordinate: new)
            case (.locating, .coordinateDidUpdated):
                break
            case (.error(let old), .catchError(let new)) where old != new:
                _state = .error(error: new)
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
        case (.locating(let lhs), .locating(let rhs)):
            return lhs == rhs
        case (.error(let lhs), .error(let rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
}
