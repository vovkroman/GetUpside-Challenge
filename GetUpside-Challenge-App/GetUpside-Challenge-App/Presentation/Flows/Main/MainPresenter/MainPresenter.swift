import UI

protocol MainStateMachineObserver: AnyObject {
    func stateDidChanched(_ stateMachine: Main.StateMachine, _ to: Main.StateMachine.State)
}

protocol MainPresentable: AnyObject {
    func onLoading()
    func onFilterChanged(_ viewModel: Filter.ViewModel)
    func onDisplay(_ viewModels: [Main.ViewModel])
    func onLocationDidChange(_ coordinates: Coordinates)
}

extension Main {
    final class Presenter {
        weak var view: MainPresentable?
        let queue: DispatchQueue = .main
    }
}

extension Main.Presenter: MainStateMachineObserver {
    func stateDidChanched(_ stateMachine: Main.StateMachine, _ from: Main.StateMachine.State) {
        print("STATE: \(stateMachine.state)")
        handleState(stateMachine.state)
    }
}

private extension Main.Presenter {
    func handleState(_ state: Main.StateMachine.State) {
        switch state {
        case .idle:
            break
        case .list(let response, let isInitial):
            onDataDidLoad(response, isInitial)
        case .error:
            break
        case .loading:
            onLoading()
        }
    }
}
