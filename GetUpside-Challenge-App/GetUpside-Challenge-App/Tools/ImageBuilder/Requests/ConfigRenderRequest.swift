import UIKit

struct ConfigRenderRequest {
    let size: CGSize
}

extension ConfigRenderRequest: ImageDescription {
    
    var shape: Shape {
        return .filtering(size: size)
    }
    
    var lineWidth: CGFloat {
        return 2.0
    }
    
    var fillColor: UIColor {
        return .white
    }
    
    var strokeColor: UIColor {
        return .darkGray
    }
    
    var gradient: Gradient? {
        return nil
    }
}
