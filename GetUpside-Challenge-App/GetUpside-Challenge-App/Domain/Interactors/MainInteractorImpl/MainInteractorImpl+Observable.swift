import Foundation

extension Main.InteractorImpl {
    func addObserves() {
        observeLocationChange()
    }
}

private extension Main.InteractorImpl {
    func observeLocationChange() {
        locationWorker.observer.observe { [weak self] result in
            switch result {
            case .success(let coordinates):
                self?.presenter.onChangeLocation(coordinates)
            case .failure(let error):
                ////
                break
            }
        }
    }
}
