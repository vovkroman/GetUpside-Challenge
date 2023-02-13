import Foundation

enum Convertor {}


extension Convertor {
    enum Error {
        case convertFailed(context: String)
    }
}

extension Convertor.Error: Error {}

protocol Convertable {
    associatedtype From
    associatedtype To
    
    func convertFromTo(from: From) throws -> To
    func convertToFrom(from: To) throws -> From
}
