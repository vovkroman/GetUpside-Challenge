import UIKit

public enum Animation {
    
    public struct Params<Value> {
        let beginTime: CFTimeInterval
        let from: Value
        let to: Value
        let duration: CFTimeInterval
        let timingFunc: CAMediaTimingFunction
        let isRemovedOnCompletion: Bool
        
        public init(
            beginTime: CFTimeInterval = 0.0,
             from: Value,
             to: Value,
             duration: CFTimeInterval,
             timingFunc: CAMediaTimingFunction,
             isRemovedOnCompletion: Bool = true
        ) {
            self.beginTime = beginTime
            self.from = from
            self.to = to
            self.duration = duration
            self.timingFunc = timingFunc
            self.isRemovedOnCompletion = isRemovedOnCompletion
        }
    }
    
    public enum KeyPath: CustomStringConvertible {
        
        case strokeStart(params: Params<CGFloat>)
        case strokeEnd(params: Params<CGFloat>)
        case transform(params: Params<CATransform3D>)
        
        case drawLineAnimation
        case revalAnimation
        
        public var description: String {
            switch self {
            case .strokeEnd:
                return "strokeEnd"
            case .strokeStart:
                return "strokeStart"
            case .drawLineAnimation:
                return "drawLineAnimation"
            case .transform:
                return "transform"
            case .revalAnimation:
                return "revalAnimation"
            }
        }
    }
}

extension CABasicAnimation {
    public convenience init(
        type: Animation.KeyPath
    ) {
        self.init(keyPath: "\(type)")
        switch type {
        case .strokeEnd(let params),
             .strokeStart(let params):
            beginTime = params.beginTime
            fromValue = params.from
            toValue = params.to
            duration = params.duration
            timingFunction = params.timingFunc
            isRemovedOnCompletion = params.isRemovedOnCompletion
        case .transform(let params):
            beginTime = params.beginTime
            fromValue = params.from
            toValue = params.to
            duration = params.duration
            timingFunction = params.timingFunc
            isRemovedOnCompletion = params.isRemovedOnCompletion
        default:
            // nothing to do
            break
        }
    }
}
