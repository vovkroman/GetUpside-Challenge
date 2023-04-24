import UIKit

extension Main.InteractorImpl {
    func addObservers() {
        observerDidEnterBackground()
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
    
    func observerDidEnterBackground() {
        token = NotificationCenter.default.observe(
            name: UIApplication.willResignActiveNotification,
            object: nil,
            queue: .main) { [weak self] _ in self?.onSave() }
    }
}
