import Foundation

public struct LetteringLayerConfig {
    let stokeColor: UIColor
    let fillColor: UIColor
    let lineWidth: CGFloat
}

public extension LetteringLayerConfig {
    static var `default`: LetteringLayerConfig {
        return LetteringLayerConfig(
            stokeColor: .white,
            fillColor: .clear,
            lineWidth: 0.0
        )
    }
}
