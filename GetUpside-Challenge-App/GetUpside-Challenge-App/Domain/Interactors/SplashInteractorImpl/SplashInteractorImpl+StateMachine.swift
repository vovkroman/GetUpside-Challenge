import Foundation

extension Splash.InteractorImpl {
    
    func locatingDidStart() {
        queue.async(execute: combine(.locatingDidStart, with: stateMachine.transition))
    }
    
    func locatingCoordinateDidUpdated(_ coordinates: Coordinates) {
        queue.async(execute: combine(.coordinatesDidUpdated(coordinates), with: stateMachine.transition))
    }
    
    func processTheError(_ error: Location.Error) {
        queue.async(execute: combine(.catchError(error), with: stateMachine.transition))
    }
}
