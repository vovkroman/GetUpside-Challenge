import Foundation

extension Splash.InteractorImpl {
    
    func locationDidRequestForAuthorization() {
        queue.sync(execute: combine(.authDidStarted, with: stateMachine.transition))
    }
    
    func locationCoordinateDidUpdated(_ coordinates: Coordinates) {
        queue.sync(execute: combine(.coordinateDidUpdated(coordinates), with: stateMachine.transition))
    }
    
    func processTheError(_ error: Location.Error) {
        queue.sync(execute: combine(.catchError(error), with: stateMachine.transition))
    }
}
