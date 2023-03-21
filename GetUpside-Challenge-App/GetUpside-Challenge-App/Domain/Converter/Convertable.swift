import Foundation

enum Convertor {}


extension Convertor {
    struct Error {
        let context: String
        
        init(_ context: String) {
            self.context = context
        }
    }
}

extension Convertor.Error: Error {}

protocol Convertable {
    associatedtype From
    associatedtype To
    
    func convertFromTo(from: From) throws -> To
    func convertToFrom(from: To) throws -> From
}
