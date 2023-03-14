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
            case startedLoading
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
            case (.idle, .startedLoading), (.list, .startedLoading), (.error, .startedLoading):
                state = .loading
            case (.idle, .loadingFinished(let new)), (.list, .loadingFinished(let new)),
                (.loading, .loadingFinished(let new)), (.error, .loadingFinished(let new)):
                state = .list(new)
            case (.loading, .startedLoading):
                // noting to do, as it's alrady loading
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

