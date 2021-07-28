import Foundation

enum NSAttributedStringBuilder {
    static func buildBlock(
        _ components: NSAttributedString...
    ) -> NSAttributedString {
        let mas = NSMutableAttributedString(string: "")
        for component in components {
            mas.append(component)
        }
        return mas
    }
}
