import Foundation

extension Main.InteractorImpl {
    
    func onLoadDidFinish(_ eateries: Main.Eateries, _ filters: Main.Filters) {
        let response = Main.Response(eateries, filters)
        queue.async(execute: combine(.loadingFinished(response), with: stateMachine.transition))
    }
}
