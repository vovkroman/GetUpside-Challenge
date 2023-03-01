import Foundation

extension Main.InteractorImpl: MainUseCase {
    
    func requestLocation() {
        if locationWorker.isUserAuthorized {
            locationWorker.startUpdatingLocation()
        } else {
            locationWorker.requestForAutorization()
        }
    }
    
    func fetchingData(_ coordinate: Coordinates) {
        apiWorker.fetchData(coordinate).observe { [weak self] result in
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
        onLoadDidFinished(eateries, filters)
    }
    
    func onStartProcessing<S: Sequence>(_ newComings: S) where S.Element == Eatery {
        for entity in newComings where !eateries.contains(entity) {
            
            // check if newcoming entity has been processed
            eateries.insert(entity)
            
            // check if newcoming filter has been processed
            if filters.contains(entity.description) { continue }
            filters.insert(entity.description)
        }
        onLoadDidFinished(eateries, filters)
    }
    
    func onLoadDidFinished(_ eateries: Main.Eateries, _ filters: Main.Filters) {
        let response = Main.Response(eateries, filters)
        queue.sync(execute: combine(.loadingFinished(response), with: stateMachine.transition))
    }
}
