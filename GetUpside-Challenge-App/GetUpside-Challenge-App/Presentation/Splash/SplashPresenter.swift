import Foundation

protocol SplashStateMachineObserver: AnyObject {
    func stateDidChanched(_ stateMachine: Splash.StateMachine, to: Splash.StateMachine.State)
}

protocol SplashPresenterSupport: AnyObject {}

protocol SplashPresentable: AnyObject {
    func onLoading()
    func onLocationDidUpdate(_ coordinate: Coordinates)
    func onErrorDidCatch(_ viewModel: Splash.ViewModel)
}

extension Splash {
    
    final class Presenter: SplashPresenterSupport {
        weak var view: SplashPresentable?
    }
}

private extension Splash.Presenter {
    
    func handleState(_ state: Splash.StateMachine.State) {
        switch state {
        case .idle, .loading:
            view?.onLoading()
        case .locating(let coordinate):
            view?.onLocationDidUpdate(coordinate)
        case .error(let error):
            let viewModel = Splash.ViewModel(error)
            view?.onErrorDidCatch(viewModel)
        }
    }
}

extension Splash.Presenter: SplashStateMachineObserver {
    
    func stateDidChanched(_ stateMachine: Splash.StateMachine, to: Splash.StateMachine.State) {
        DispatchQueue.main.async(execute: combine(to, with: handleState))
    }
}
