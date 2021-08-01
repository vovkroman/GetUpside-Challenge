import Foundation

@resultBuilder
class NSAttributedStringBuilder {
    static func buildBlock(
        _ components: NSAttributedString...
    ) -> NSAttributedString {
        let result = NSMutableAttributedString(string: "")
        
        return components.reduce(into: result) { (result, current) in result.append(current) }
    }
}

extension NSAttributedString {
    class func composing(@NSAttributedStringBuilder _ parts: () -> NSAttributedString) -> NSAttributedString {
        return parts()
    }
}

// Usage
/*
 let result = NSAttributedString.composing {
     NSAttributedString(string: "Hello",
                        attributes: [.font: UIFont.systemFont(ofSize: 24),
                                     .foregroundColor: UIColor.red])
     NSAttributedString(string: " world!",
                        attributes: [.font: UIFont.systemFont(ofSize: 20),
                                     .foregroundColor: UIColor.orange])
 }
 */
