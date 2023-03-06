import Foundation

extension Main {
    
    final class StateMachine {
        enum State {
            case idle
            case list(Main.Response)
            case loading
            case error
        }
        
        enum Event {
            case loadingFinished(Main.Response)
        }
        
        weak var observer: MainStateMachineObserver?
        
        private(set) var state: State = .idle {
            didSet {
                guard oldValue != state else { return }
                observer?.stateDidChanched(
                    self,
                    oldValue
                )
            }
        }
        
        func transition(with event: Event) {
            switch (state, event) {
            case (.idle, .loadingFinished(let response)):
                state = .list(response)
            case (.list(_), .loadingFinished(let new)):
                state = .list(new)
            default:
                break
            }
        }
    }
}

extension Main.StateMachine.State: Equatable {
    
    static func == (
        lhs: Main.StateMachine.State,
        rhs: Main.StateMachine.State
    ) -> Bool {
        return false
    }
}

