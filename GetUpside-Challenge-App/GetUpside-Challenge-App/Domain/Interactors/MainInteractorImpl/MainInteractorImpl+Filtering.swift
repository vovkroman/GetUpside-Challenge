import FutureKit
import FilterKit

extension Main.InteractorImpl {
    
    func applyCategoryFilter(_ id: String) {
        let spec = CategorySpec(id)
        queue.async(execute: combine(spec, id, with: executeFilter))
    }
    
    func applyFilterNearMe(_ id: String) {
        locationWorker.observer.observe { [weak self] result in
            switch result {
            case .success(let coordinates):
                self?.applyNearMeFilter(id, coordinates)
            case .failure(let error):
                break
            }
        }
        onLoadingStarted()
        locationWorker.requestLocating()
    }
    
    func removeFilter(_ id: String) {
        queue.async(execute: combine(id, with: remove))
    }
}

private extension Main.InteractorImpl {
    
    func executeFilter<Spec: Specification>(_ spec: Spec, _ id: String) where Spec.Item == Eatery {
        executor.apply(spec, id)
        onLoadingStarted()
        let filtered = executor.filter(eateries)
        onLoadDidFinish(filtered, filters)
    }
    
    func remove(_ id: String) {
        executor.remove(id)
        onLoadingStarted()
        let filtered = executor.filter(eateries)
        onLoadDidFinish(filtered, filters)
    }
    
    func applyNearMeFilter(_ id: String, _ coordinates: Coordinates) {
        let Location = Constant.Location.self
        let spec = DistanceSpec(
            coordinates,
            Location.distanceTwentyThousandMeters
        )
        queue.async(execute: combine(spec, id, with: executeFilter))
    }
}
