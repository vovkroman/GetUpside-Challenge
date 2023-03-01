import Foundation

extension Splash.InteractorImpl: SplashUseCase {
    
    var isUserAuthorized: Bool {
        return locationWorker.isUserAuthorized
    }
    
    func requestLocation() {
        if isUserAuthorized {
            locationWorker.startUpdatingLocation()
        } else {
            locationDidRequestForAuthorization()
            locationWorker.requestForAutorization()
        }
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
