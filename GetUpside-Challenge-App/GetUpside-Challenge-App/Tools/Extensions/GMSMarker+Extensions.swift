import Foundation
import GoogleMaps

extension GMSMarker {
    
    func select() {
        guard let iconView = iconView as? Animatable else { return }
        iconView.startAnimation()
    }
    
    func deselect() {
        guard let iconView = iconView as? Animatable else { return }
        iconView.endAnimation()
    }
}
