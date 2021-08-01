import Foundation

extension Optional where Wrapped == String {
    var orEmpty: String {
        switch self {
        case .some(let value):
            return value
        case .none:
            return ""
        }
    }
}
// Usage:
/*
 let label = UILabel()
 label.text = "This is some text."
 doesNotWorkWithOptionalString(label.text.orEmpty)
 */

extension Optional {
    func orThrow(_ errorExpression: @autoclosure () -> Error) throws -> Wrapped {
        switch self {
        case .some(let value):
            return value
        case .none:
            throw errorExpression()
        }
    }
}

// Usage: let file = try loadFile(at: path).orThrow(MissingFileError())
