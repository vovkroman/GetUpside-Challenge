import FutureKit

extension Main.InteractorImpl: MainUseCase {
    
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
        var newComings: [Eatery] = []
        for entity in eateries {
            // check if newcoming filter has been processed
            newComings.append(entity)
            if filters.contains(entity.description) { continue }
            filters.insert(entity.description)
        }
        onLoadDidFinish(newComings, filters)
    }
    
    func handleNewEateries<S: Sequence>(_ newComings: S) where S.Element == Eatery {
        onLoadingStarted()
        for entity in newComings where !eateries.contains(entity) {
            
            // check if newcoming entity has been processed
            eateries.insert(entity)
            
            // check if newcoming filter has been processed
            if filters.contains(entity.description) { continue }
            filters.insert(entity.description)
        }
        onLoadDidFinish(executor.filter(eateries), filters)
    }
}
