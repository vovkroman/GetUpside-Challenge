import Foundation

public struct AnySpec<T>: Specification {
    
    public typealias Item = T
    
    private let _isSatisfied: (T) -> Bool
    private let _hash: (inout Hasher) -> Void
    
    public func hash(into hasher: inout Hasher) {
        _hash(&hasher)
    }
    
    public func isSatisfied(_ item: T) -> Bool {
        return _isSatisfied(item)
    }
    
    public static func == (lhs: AnySpec<T>, rhs: AnySpec<T>) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    public init<Spec: Specification>(_ spec: Spec) where Spec.Item == T {
        _isSatisfied = spec.isSatisfied
        _hash = spec.hash
    }
}
