import FutureKit

extension Main.InteractorImpl: MainUseCase {
    
    func onStart() {
        addObserves()
        onInitialLoaded()
    }
    
    func requestLocation() {
        // Noting to do
    }
    
    func fetchingData(_ coordinates: Coordinates) {
        apiWorker.fetchData(coordinates).observe { [weak self] result in
            switch result {
            case .success(let entities):
                self?.onProcessNewEateries(entities)
            case .failure(let error):
                // self?._presenter.locationCatch(the: .other(error))
                break
            }
        }
    }
    
    func onStoreLast(_ k: Int = 20, _ eateries: [Eatery]) {
        let count = eateries.count
        dbWorker.save(Array(eateries[max(0, count - k)..<count]))
    }
}

extension Main.InteractorImpl {
    
    func onInitialLoaded() {
        queue.async(execute: combine(with: handleInitialLoading))
    }
    
    func onProcessNewEateries<S: Sequence>(_ newComings: S) where S.Element == Eatery {
        queue.async(execute: combine(newComings, with: handleNewEateries))
    }
}

private extension Main.InteractorImpl {
        
    func handleInitialLoading() {
        onLoadingStarted()
        var newEateries: [Eatery] = []
        var newFilterIds: [Filter.Model] = []
        var index = 0
        for entity in eateries {
            // check if newcoming filter has been processed
            newEateries.append(entity)
            
            let filterId = entity.description
            if filters.contains(filterId) { continue }
            filters.insert(filterId)
            newFilterIds.append(Filter.Model(filterId, index))
            index += 1
        }
        onStoreLast(20, newEateries)
        onInitialLoadingDidFinish(newEateries, newFilterIds)
    }
    
    func handleNewEateries<S: Sequence>(_ newComings: S) where S.Element == Eatery {
        onLoadingStarted()
        var newFilterIds: [Filter.Model] = []
        var idx = filters.count
        for entity in newComings where !eateries.contains(entity) {
            
            // check if newcoming entity has been processed
            eateries.insert(entity)
            
            // check if newcoming filter has been processed
            let filterId = entity.description
            if filters.contains(filterId) { continue }
            filters.insert(filterId)
            newFilterIds.append(Filter.Model(filterId, idx))
            idx += 1
        }
        let items = executor.filter(eateries)
        onStoreLast(20, items)
        onLoadDidFinish(items, newFilterIds)
    }
}
