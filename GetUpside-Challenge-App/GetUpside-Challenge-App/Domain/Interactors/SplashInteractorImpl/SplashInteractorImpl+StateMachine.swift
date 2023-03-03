import Foundation

extension Splash.InteractorImpl {
    
    func locationDidRequestForAuthorization() {
        queue.async(execute: combine(.authDidStarted, with: stateMachine.transition))
    }
    
    func locationCoordinateDidUpdated(_ coordinates: Coordinates) {
        queue.async(execute: combine(.coordinateDidUpdated(coordinates), with: stateMachine.transition))
    }
    
    func processTheError(_ error: Location.Error) {
        queue.async(execute: combine(.catchError(error), with: stateMachine.transition))
    }
}
