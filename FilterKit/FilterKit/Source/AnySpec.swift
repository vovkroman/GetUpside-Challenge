import Foundation

public struct AnySpec<T>: Specification {
    
    public typealias Item = T
    
    private let _isSatisfied: (T) -> Bool
    
    public func isSatisfied(_ item: T) -> Bool {
        return _isSatisfied(item)
    }
    
    public init<Spec: Specification>(_ spec: Spec) where Spec.Item == T {
        _isSatisfied = spec.isSatisfied
    }
}
