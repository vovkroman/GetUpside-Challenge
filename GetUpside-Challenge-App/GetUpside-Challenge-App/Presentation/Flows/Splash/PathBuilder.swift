import Foundation

struct PathBuilder {
    
    private let _size: CGSize
    private let _shape: ShapeSupportable
        
    init(_ size: CGSize, _ shape: ShapeSupportable) {
        _size = size
        _shape = shape
    }
}
