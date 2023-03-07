import UIKit

enum ConfigRenderRequest {
    case sorting(size: CGSize)
    case filtering(size: CGSize)
}

extension ConfigRenderRequest: ImageDescription {
    var size: CGSize {
        switch self {
        case .sorting(let size):
            return size
        case .filtering(let size):
            return size
        }
    }
    
    var shape: Shape {
        switch self {
        case .filtering(let size):
            return .filtering(size: size)
        case .sorting(let size):
            return .sorting(size: size)
        }
    }
    
    var lineWidth: CGFloat {
        return 2.0
    }
    
    var fillColor: UIColor {
        return .lightGray
    }
    
    var strokeColor: UIColor {
        return .gray
    }
    
    var gradient: Gradient? {
        return nil
    }
}
