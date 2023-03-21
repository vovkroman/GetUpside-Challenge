import FutureKit

enum DB {}

extension DB {
    
    class Worker {
        
        private let manager: RealmSpace.Manager
        
        func performFetching() -> Future<[Eatery]> {
            return manager.request(aClass: RealmEatery.self)
                           .transformed { results in
                               let converter = Convertor.RealmEateryConverter()
                               return try converter.convertFromTo(from: results)
                           }
        }
        
        init(_ manager: RealmSpace.Manager) {
            self.manager = manager
        }
    }
}

extension DB.Worker: GetEateriesUseCase {
    
    func fetchData(_ coordinate: Coordinates) -> FutureKit.Future<[Eatery]> {
        return performFetching()
    }
    
    func cancelFetching() {
        // Nothing to do
    }
}
