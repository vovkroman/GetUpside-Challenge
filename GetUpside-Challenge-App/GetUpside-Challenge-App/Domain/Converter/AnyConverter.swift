import Foundation

class AnyConverter<F, T>: Convertable {
    
    typealias From = F
    typealias To = T
    
    func convertFromTo(from: From) throws -> To {
        return try convertFromTo(from)
    }
    
    func convertToFrom(from: To) throws -> From {
        return try convertToFrom(from)
    }
    
    private let convertFromTo: (F) throws -> T
    private let convertToFrom: (T) throws -> F
    
    init<Converter: Convertable>(_ c: Converter) where Converter.From == F, Converter.To == T{
        convertFromTo = c.convertFromTo
        convertToFrom = c.convertToFrom
    }
}
