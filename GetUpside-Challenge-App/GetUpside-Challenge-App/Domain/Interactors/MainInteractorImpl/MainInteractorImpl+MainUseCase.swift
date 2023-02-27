import Foundation

extension Main.InteractorImpl: MainUseCase {
    
    private func onLoadedData(_ newComings: [Eatery]) {
        var new: Set<Eatery> = Set()
        for entity in newComings {
            
            // check if newcoming entity has been processed
            if entities.contains(entity) { continue }
            entities.insert(entity)
            new.insert(entity)
        }
        presenter.onDataDidLoad(new)
    }
    
    func requestLocation() {
        if locationWorker.isUserAuthorized {
            locationWorker.startUpdatingLocation()
        } else {
            locationWorker.requestForAutorization()
            presenter.locationDidRequestForAuthorization()
        }
    }
    
    func fetachData(_ coordinate: Coordinates) {
        apiWorker.fetchData(coordinate).observe { [weak self] result in
            switch result {
            case .success(let entities):
                self?.onLoadedData(entities)
            case .failure(let error):
                    //self?._presenter.locationCatch(the: .other(error))
                break
            }
        }
    }
}
