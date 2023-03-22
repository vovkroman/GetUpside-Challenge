import FutureKit
import Logger

enum DB {}

extension DB {
    
    class Worker {
        
        typealias Converter = AnyConverter<Array<RealmEatery>, [Eatery]>
        
        private let manager: RealmSpace.Manager
        private let converter: Converter
        private var queue: DispatchQueue {
            return manager.queue
        }
        
        init(_ manager: RealmSpace.Manager, _ converter: Converter) {
            self.manager = manager
            self.converter = converter
        }
    }
}

extension DB.Worker: GetEateriesUseCase, EateriesSavable {
    
    func save(_ eateries: [Eatery]) {
        removeAndStore(eateries)
    }
    
    func fetchData(_ coordinate: Coordinates) -> Future<[Eatery]> {
        let promise = Promise<[Eatery]>()
        do {
            let items = try requestEateries()
            promise.resolve(with: items)
        } catch let error {
            promise.reject(with: error)
        }
        return promise
    }
    
    func cancelFetching() {
        // Nothing to do
    }
}

private extension DB.Worker {
    
    func requestEateries() throws -> [Eatery] {
        return try queue.syncExecute {
            let objects = try manager.readAll(aClass: RealmEatery.self)
            return try converter.convertFromTo(from: Array(objects))
        }
    }
    
    func removeAndStore(_ eateries: [Eatery]) {
        queue.asyncExecute(flags: .barrier) { [weak self] in
            guard let manager = self?.manager,
                    let converter = self?.converter else { return }
            do {
                try manager.removeAll(aClass: RealmEatery.self)
                try manager.write(try converter.convertToFrom(from: eateries))
            } catch {
                Logger.error("Unable to save to Realm")
            }
        }
    }
}
