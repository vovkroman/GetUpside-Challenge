import Foundation

public struct AnySpec<T>: Specification {
    
    public typealias Item = T
    
    private let isSatisfied: (T) -> Bool
    
    public func isSatisfied(_ item: T) -> Bool {
        return isSatisfied(item)
    }
    
    public init<Spec: Specification>(_ spec: Spec) where Spec.Item == T {
        isSatisfied = spec.isSatisfied
    }
}
