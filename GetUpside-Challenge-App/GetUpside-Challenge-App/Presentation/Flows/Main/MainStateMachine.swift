import Foundation

extension Main {
    
    final class StateMachine {
        enum State {
            case idle
            case list(response: Main.Response, isInitial: Bool)
            case loading
            case error
        }
        
        enum Event {
            case startedLoading
            case initialLoadingDidFinish(Main.Response)
            case loadingDidFinish(Main.Response)
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
            case (.idle, .initialLoadingDidFinish(let new)), (.list, .initialLoadingDidFinish(let new)),
                (.loading, .initialLoadingDidFinish(let new)), (.error, .initialLoadingDidFinish(let new)):
                state = .list(response: new, isInitial: true)
            case (.idle, .loadingDidFinish(let new)), (.list, .loadingDidFinish(let new)),
                (.loading, .loadingDidFinish(let new)), (.error, .loadingDidFinish(let new)):
                state = .list(response: new, isInitial: false)
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

