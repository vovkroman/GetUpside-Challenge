import Foundation

protocol Filterable {
    
    associatedtype T
    
    func filter<Spec: Specification, S: Sequence>(_ items: S, specs: Spec) -> [T] where Spec.Item == T, S.Element == T
}

struct Filter<T>: Filterable {
    
    func filter<Spec: Specification, S: Sequence>(_ items: S, specs: Spec) -> [T] where T == Spec.Item, S.Element == T {
        var output: [T] = []
        for item in items {
            if specs.isSatisfied(item) {
                output.append(item)
            }
        }
        return output
    }
}
