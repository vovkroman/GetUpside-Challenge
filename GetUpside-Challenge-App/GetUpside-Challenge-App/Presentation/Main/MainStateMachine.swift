import Foundation

extension Main {
    final class StateMachine {
        enum State {
            case idle
            case list([ViewModel])
            case loading
            case operating
            case error
        }
        
        enum Event {
            case loadingFinished(viewModels: [ViewModel])
        }
        
        weak var observer: MainStateMachineObserver?
        
        private var _state: State = .idle {
            didSet {
                guard oldValue != _state else { return }
                observer?.stateDidChanched(
                    self,
                    _state
                )
            }
        }
        
        func transition(with event: Event) {
            switch (_state, event) {
            case (.idle, .loadingFinished(let viewModels)):
                _state = .list(viewModels)
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

