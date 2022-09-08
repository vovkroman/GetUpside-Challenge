import Foundation

protocol MainStateMachineObserver: AnyObject {
    func stateDidChanched(_ stateMachine: Main.StateMachine, to: Main.StateMachine.State)
}

protocol MainDataLoadable: AnyObject {
    func dataDidLoaded(_ items: Set<Eatery>)
}

extension Main {
    final class Presenter {
        private let _stateMachine: StateMachine = StateMachine()
        private let _queue: DispatchQueue
        
        weak var observer: MainStateMachineObserver? {
            didSet {
                _stateMachine.observer = observer
            }
        }
        
        init(_ queue: DispatchQueue) {
            _queue = queue
        }
    }
}

extension Main.Presenter: MainPresentable {
    
    func dataDidLoaded(_ items: Set<Eatery>) {
        let viewModels = items.compactMap(Main.ViewModel.init)
        _queue.sync(execute: combine(.loadingFinished(viewModels: viewModels), with: _stateMachine.transition))
    }
    
    func locationDidRequestForAuthorization() {
        
    }
    
    func locationDidUpdated(with coordinate: Coordinates) {
        
    }
    
    func locationCatch(the error: Location.Error) {
        
    }
}
