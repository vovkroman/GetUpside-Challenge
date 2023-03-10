import FutureKit

extension Main.InteractorImpl {
    
    func applyCategoryFilter(_ key: String) {
        presenter.applyFilter(key)
        onLoadDidFinish(eateries, [])
    }
    
    func removeCategoryFilter(_ key: String) {
        presenter.removeFilter(key)
        onLoadDidFinish(eateries, [])
    }
    
    func applyFilterNearMe() {
        locationWorker.observer.observe { [weak self] result in
            switch result {
            case .success(let coordinates):
                self?.addFilterMearMe(coordinates)
            case .failure(let error):
                break
            }
        }
        locationWorker.requestLocating()
    }
}

extension Main.InteractorImpl {
    func addFilterMearMe(_ coordinates: Coordinates) {
        presenter.applyFilterNearMe(coordinates)
        onLoadDidFinish(eateries, [])
    }
}
