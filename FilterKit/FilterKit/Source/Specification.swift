import Foundation

    //MARK: Specifications

public protocol Specification: Hashable {
    
    associatedtype Item
    
    func isSatisfied(_ item: Item) -> Bool
}
