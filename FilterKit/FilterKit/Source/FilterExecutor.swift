import Foundation

public struct FilterExecutor<T> {
    
    private var specs: Set<AnySpec<T>>
    
    public mutating func apply<Spec: Specification>(_ spec: Spec) where Spec.Item == T {
        specs.insert(AnySpec(spec))
    }
    
    public mutating func remove<Spec: Specification>(_ spec: Spec) where Spec.Item == T {
        specs.remove(AnySpec(spec))
    }
    
    public init() {
        specs = []
    }
    
    public func filter<S: Sequence>(_ items: S) -> [T] where S.Element == T {
        guard !specs.isEmpty else {
            return Array(items)
        }
        var output: [T] = []
        for item in items {
            for spec in specs where spec.isSatisfied(item) {
                output.append(item)
            }
        }
        return output
    }
}
