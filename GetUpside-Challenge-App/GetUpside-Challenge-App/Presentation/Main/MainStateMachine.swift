import Foundation

extension Main {
    
    struct Response {
        let viewModels: ContiguousArray<ViewModel>
        let filters: ContiguousArray<Filter.ViewModel>
    }
    
    final class StateMachine {
        enum State {
            case idle
            case list(Response)
            case loading
            case operating
            case error
        }
        
        enum Event {
            case loadingFinished(respons: Response)
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
            case (.idle, .loadingFinished(let response)):
                _state = .list(response)
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

