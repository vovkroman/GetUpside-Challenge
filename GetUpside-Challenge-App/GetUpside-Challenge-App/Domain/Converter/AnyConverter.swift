import Foundation

class AnyConverter<F, T>: Convertable {
    
    typealias From = F
    typealias To = T
    
    func convertFromTo(from: From) throws -> To {
        return try _convertFromTo(from)
    }
    
    func convertToFrom(from: To) throws -> From {
        return try _convertToFrom(from)
    }
    
    private let _convertFromTo: (F) throws -> T
    private let _convertToFrom: (T) throws -> F
    
    init<Converter: Convertable>(_ c: Converter) where Converter.From == F, Converter.To == T{
        _convertFromTo = c.convertFromTo
        _convertToFrom = c.convertToFrom
    }
}
