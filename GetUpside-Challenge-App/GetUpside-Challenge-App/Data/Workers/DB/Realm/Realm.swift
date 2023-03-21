import RealmSwift
import FutureKit

enum RealmSpace {}

enum RealmError: Error {
    case empty
    case other(String)
}

extension RealmSpace {
    
    class Manager {
        
        private let queue: DispatchQueue
        
        private lazy var core: Realm = {
            return try! Realm(queue: queue)
        }()
        
        func save<O: Object>(_ object: O) -> Future<Bool> {
            let promise = Promise<Bool>()
            queue.async { [weak self] in
                do {
                    try self?.write(object)
                    promise.resolve(with: true)
                } catch let error {
                    promise.reject(with: error)
                }
            }
            return promise
        }
        
        func save<O: Object, S: Collection>(_ objects: S) -> Future<Bool> where S.Element == O {
            let promise = Promise<Bool>()
            queue.async { [weak self] in
                do {
                    try self?.write(objects)
                    promise.resolve(with: true)
                } catch let error {
                    promise.reject(with: error)
                }
            }
            return promise
        }
        
        func request<O: Object>(aClass: O.Type) -> Future<Results<O>> {
            let promise = Promise<Results<O>>()
            queue.async { [weak self] in
                do {
                    guard let objects = try self?.read(aClass: O.self) else {
                        throw RealmError.empty
                    }
                    promise.resolve(with: objects)
                } catch let error {
                    promise.reject(with: error)
                }
            }
            return promise
        }
        
        init(_ queue: DispatchQueue) {
            self.queue = queue
        }
    }
}

private extension RealmSpace.Manager {
    
    func write<O: Object>(_ object: O) throws {
        try core.write {
            core.add(object)
        }
    }
    
    func write<O: Object, S: Collection>(_ objects: S) throws where S.Element == O {
        try core.write {
            core.add(objects)
        }
    }
    
    func read<O: Object>(aClass: O.Type) throws -> Results<O> {
        if core.isEmpty {
            throw RealmError.empty
        }
        let objects = core.objects(aClass)
        return objects
    }
    
}
