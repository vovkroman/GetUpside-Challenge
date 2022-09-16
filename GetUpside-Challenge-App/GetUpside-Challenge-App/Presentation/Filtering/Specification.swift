import Foundation

//MARK: Specifications
protocol Specification {
    
    associatedtype Item

    func isSatisfied(_ item: Item) -> Bool
}

struct AnySpec<T>: Specification {
    
    typealias Item = T
    
    private let _isSatisfied: (T) -> Bool
    
    func isSatisfied(_ item: T) -> Bool {
        return _isSatisfied(item)
    }
    
    init<Spec: Specification>(_ spec: Spec) where Spec.Item == T {
        _isSatisfied = spec.isSatisfied
    }
}

struct EmptySpec<T>: Specification {
    
    typealias Item = T
    
    func isSatisfied(_ item: T) -> Bool {
        return true
    }
}

struct AndSpec<T, SpecA: Specification, SpecB: Specification>: Specification where T == SpecA.Item, SpecA.Item == SpecB.Item {
    
    var specA: SpecA
    var specB: SpecB
    
    init(_ specA: SpecA, _ specB: SpecB) {
        self.specA = specA
        self.specB = specB
    }
    
    func isSatisfied(_ item: T) -> Bool {
        return specA.isSatisfied(item) && specB.isSatisfied(item)
    }
}
