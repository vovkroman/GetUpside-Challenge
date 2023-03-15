import Foundation

extension Main.InteractorImpl {
    
    func onLoadingStarted() {
        stateMachine.transition(with: .startedLoading)
    }
    
    func onInitialLoadingDidFinish(_ eateries: [Main.Model], _ filters: [Filter.Model]) {
        let response = Main.Response(eateries, filters)
        stateMachine.transition(with: .initialLoadingDidFinish(response))
    }
    
    func onLoadDidFinish(_ eateries: [Main.Model], _ filters: [Filter.Model]) {
        let response = Main.Response(eateries, filters)
        stateMachine.transition(with: .loadingDidFinish(response))
    }
}
