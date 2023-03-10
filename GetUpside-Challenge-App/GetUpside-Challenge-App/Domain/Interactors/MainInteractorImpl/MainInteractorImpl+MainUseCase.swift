import FutureKit

extension Main.InteractorImpl: MainUseCase {
    
    func requestLocation() {
        // Noting to do
    }
    
    func fetchingData(_ coordinates: Coordinates) {
        apiWorker.fetchData(coordinates).observe { [weak self] result in
            switch result {
            case .success(let entities):
                self?.onStartProcessing(entities)
            case .failure(let error):
                // self?._presenter.locationCatch(the: .other(error))
                break
            }
        }
    }
}

extension Main.InteractorImpl {
    
    func onInitialLoad() {
        for entity in eateries {
            // check if newcoming filter has been processed
            if filters.contains(entity.description) { continue }
            filters.insert(entity.description)
        }
        onLoadDidFinish(eateries, filters)
    }
    
    func onStartProcessing<S: Sequence>(_ newComings: S) where S.Element == Eatery {
        for entity in newComings where !eateries.contains(entity) {
            
            // check if newcoming entity has been processed
            eateries.insert(entity)
            
            // check if newcoming filter has been processed
            if filters.contains(entity.description) { continue }
            filters.insert(entity.description)
        }
        onLoadDidFinish(eateries, filters)
    }
}
