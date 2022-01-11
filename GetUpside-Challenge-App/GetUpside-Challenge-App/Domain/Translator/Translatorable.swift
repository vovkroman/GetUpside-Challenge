import Foundation

protocol Translatorable {
    associatedtype From
    associatedtype To
    
    func convert(from: From) -> To
    func convert(from: To) -> From
}
