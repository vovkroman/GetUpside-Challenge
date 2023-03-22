import RealmSwift

enum RealmSpace {}

struct RealmError: Error {
    
    let context: String
    
    init(_ context: String) {
        self.context = context
    }
}

extension RealmSpace {
    
    class Manager {
        
        let queue: DispatchQueue
        
        private lazy var core: Realm = {
            return try! Realm(queue: queue)
        }()
        
        func write<O: Object>(_ object: O) throws {
            try core.write {
                core.add(object)
            }
        }
        
        func write<S: Collection>(_ objects: S) throws where S.Element: Object {
            try core.write {
                core.add(objects)
            }
        }
        
        func readAll<O: Object>(aClass: O.Type) throws -> Results<O> {
            let objects = core.objects(aClass)
            return objects
        }
        
        func removeAll<O: Object>(aClass: O.Type) throws {
            let objects = try readAll(aClass: aClass)
            try core.write {
                core.delete(objects)
            }
        }
        
        init(_ queue: DispatchQueue) {
            self.queue = queue
        }
    }
}
