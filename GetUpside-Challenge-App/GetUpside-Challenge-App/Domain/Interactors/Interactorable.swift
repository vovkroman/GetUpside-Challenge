import Foundation

protocol Interactorable {
    associatedtype T
    
    init(interactor: T)
}
