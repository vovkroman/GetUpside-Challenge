import UIKit

open class LetteringLayer: CAShapeLayer {
    
    // MARK: - Private API
    
    public var textPath: CGPath?
    public var config: Config = .default
    
    open func updateLayer() {
        guard let textPath = textPath else { return }
        let boundingBox = textPath.boundingBox
//        let scaleX = bounds.size.width / boundingBox.size.width
//        let scaleY = bounds.size.height / boundingBox.size.height
//
//        let factor = max(scaleX, scaleY)
//        var scale = CGAffineTransform(scaleX: factor, y: factor)
//        var changedPath = textPath.copy(using: &scale)
//
        
        // to center path
        let dx = round((bounds.size.width - boundingBox.size.width) * 0.5)
        let dy = round((bounds.size.height - boundingBox.size.height) * 0.5)
        var translate = CGAffineTransform(translationX: dx, y: dy)
        let changedPath = textPath.copy(using: &translate)
        path = changedPath
    }
    
    private func _setup() {
        strokeColor = config.stokeColor.cgColor
        fillColor = config.fillColor.cgColor
        contentsScale = UIScreen.main.scale
        isGeometryFlipped = true
        lineWidth = config.lineWidth
        lineCap = .round
    }
    
    // MARK: - Public methods
    
    public override init() {
        super.init()
        _setup()
    }
    
    public override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        _setup()
    }
    
    open func start() {
        let strokeAnimationGroup = CAAnimationGroup()
        
        let _inAnimation = CABasicAnimation(type: .strokeEnd(params: Animation.Params(beginTime: 0.0,
                                                                                      from: 0.0,
                                                                                      to: 1.0,
                                                                                      duration: 3.0,
                                                                                      timingFunc: .init(name: .easeIn))))
        
        let _outAnimation = CABasicAnimation(type: .strokeStart(params: Animation.Params(beginTime: _inAnimation.duration,
                                                                                         from: 0.0,
                                                                                         to: 1.0,
                                                                                         duration: 3.0,
                                                                                         timingFunc: .init(name: .easeInEaseOut))))
        
        
        strokeAnimationGroup.duration = _inAnimation.duration + _outAnimation.duration
        
        strokeAnimationGroup.repeatCount = .infinity
        strokeAnimationGroup.animations = [_inAnimation, _outAnimation]
        
        let id = Animation.KeyPath.self
        add(strokeAnimationGroup, forKey: "\(id.drawLineAnimation)")
    }
}
