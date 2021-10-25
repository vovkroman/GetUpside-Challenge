import Foundation

extension Splash {
    final class StateMachine {
        
        enum State {
            case idle
            case loading
            case items
            case error
        }
        
        enum Event {
            
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
            case (_, _):
                break
            default:
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
             (.loading, .loading),
             (.items, .items),
             (.error, .error):
            return true
        default:
            return false
        }
    }
}
