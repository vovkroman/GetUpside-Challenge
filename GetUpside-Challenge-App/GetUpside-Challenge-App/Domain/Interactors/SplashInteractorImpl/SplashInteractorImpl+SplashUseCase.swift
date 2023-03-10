import Foundation

extension Splash.InteractorImpl: SplashUseCase {
    
    func requestLocation() {
        locatingDidStart()
        locationWorker.observer.observe { [weak self] result in
            switch result {
            case .success(let coordinates):
                self?.locatingCoordinateDidUpdated(coordinates)
            case .failure(let error as Location.Error):
                self?.processTheError(error)
            case .failure(let error):
                self?.processTheError(.other(error))
            }
        }
        locationWorker.requestLocating()
    }
    
    func fetchingData(_ coordinate: Coordinates) {
        apiWorker.fetchData(coordinate).observe { [weak self] result in
            switch result {
            case .success(let items):
                self?.coordinator?.cacthTheEvent(items)
            case .failure(let error):
                self?.processTheError(.other(error))
            case .failure(let error as NSError) where any(value: error.code, items: NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet):
                
                break
            }
        }
    }
    
    func cancelFetching() {
        apiWorker.cancelFetching()
    }
}
