import Foundation

extension Main.InteractorImpl {
    
    func onLoadingStarted() {
        stateMachine.transition(with: .startedLoading)
    }
    
    func onLoadDidFinish(_ eateries: [Eatery], _ filters: Main.Filters) {
        let response = Main.Response(eateries, filters)
        stateMachine.transition(with: .loadingFinished(response))
    }
}
