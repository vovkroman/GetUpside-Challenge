import UI
import FilterKit

protocol MainStateMachineObserver: AnyObject {
    func stateDidChanched(_ stateMachine: Main.StateMachine, _ to: Main.StateMachine.State)
}

protocol MainDataLoadable: AnyObject {
    func onDataDidLoad(_ response: Main.Response)
}

protocol FilterSupporting: AnyObject {
    func applyFilterNearMe(_ coorindates: Coordinates)
    func applyFilter(_ key: String)
    func removeFilter(_ key: String)
}

protocol MainPresentable: AnyObject {
    func onLoading()
    func onFilterChanged(_ viewModel: Filter.ViewModel)
    func onDisplay(_ viewModels: [Main.ViewModel])
}

extension Main {
    final class Presenter {
        weak var view: MainPresentable?
        var executor: FilterExecutor<Eatery> = FilterExecutor<Eatery>()
        let queue: DispatchQueue = DispatchQueue.main
    }
}

extension Main.Presenter: MainStateMachineObserver {
    func stateDidChanched(_ stateMachine: Main.StateMachine, _ from: Main.StateMachine.State) {
        handleState(stateMachine.state)
    }
}

private extension Main.Presenter {
    func handleState(_ state: Main.StateMachine.State) {
        switch state {
        case .idle: break
        case .list(let response):
            onDataDidLoad(response)
        case .error:
            break
        case .loading:
            break
        }
    }
}
