import Foundation

    //MARK: Specifications

public protocol Specification {
    
    associatedtype Item
    
    func isSatisfied(_ item: Item) -> Bool
}
