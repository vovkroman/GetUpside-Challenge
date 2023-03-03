import Foundation

public struct Config {
    public let stokeColor: UIColor
    public let fillColor: UIColor
    public let lineWidth: CGFloat
    
    public init(_ stokeColor: UIColor, _ fillColor: UIColor, _ lineWidth: CGFloat) {
        self.stokeColor = stokeColor
        self.fillColor = fillColor
        self.lineWidth = lineWidth
    }
}

public extension Config {
    static var `default`: Config {
        return Config(
            .white,
            .clear,
            4.0
        )
    }
}
