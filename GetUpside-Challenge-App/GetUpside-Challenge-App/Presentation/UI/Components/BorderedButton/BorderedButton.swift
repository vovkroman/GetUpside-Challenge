//
//  BorderedButton.swift
//  GetUpside-Challenge-App
//
//  Created by Roman Vovk on 02.11.2021.
//

import UIKit

@IBDesignable
final class BorderedButton: UIButton {

    @IBInspectable
    var borderColor: UIColor = .white
    
    @IBInspectable
    var fillColor: UIColor = .black
    
    @IBInspectable
    var borderWidth: CGFloat = 1.0
    
    @IBInspectable
    var cornerRadius: CGFloat = 4.0
    
    private weak var _borderLayer: CAShapeLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.borderWidth = borderWidth
        borderLayer.fillColor = fillColor.cgColor
        _borderLayer = borderLayer
        layer.addSublayer(borderLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let rectCorners: UIRectCorner = .allCorners
        
        let borderPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: rectCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        _borderLayer?.path = borderPath.cgPath
    }

}
