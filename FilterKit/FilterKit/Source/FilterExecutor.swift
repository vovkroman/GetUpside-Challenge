import Foundation

public struct FilterExecutor<Key: Hashable, Value> {
    
    private var specs: [Key: AnySpec<Value>]
    
    public mutating func apply<Spec: Specification>(_ spec: Spec, _ key: Key) where Spec.Item == Value {
        guard specs[key] == nil else { return }
        specs[key] = AnySpec(spec)
    }
    
    public mutating func remove(_ key: Key){
        specs[key] = nil
    }
    
    public init() {
        specs = [:]
    }
    
    public func filter<S: Sequence>(_ items: S) -> [Value] where S.Element == Value {
        guard !specs.isEmpty else {
            return Array(items)
        }
        var output: [Value] = []
        for item in items {
            for spec in specs.values where spec.isSatisfied(item) {
                output.append(item)
            }
        }
        return output
    }
}
