import Foundation

extension Main {
    final class Presenter {
        private let _queue: DispatchQueue
        
        init(_ queue: DispatchQueue) {
            _queue = queue
        }
    }
}

extension Main.Presenter: LocationPresenting {
    func locationDidRequestForAuthorization() {
        // prepare data for display
    }
    
    func locationDidUpdated(with coordinate: Coordinate) {
        
    }
    
    func locationCatch(the error: Location.Error) {
        
    }
}
