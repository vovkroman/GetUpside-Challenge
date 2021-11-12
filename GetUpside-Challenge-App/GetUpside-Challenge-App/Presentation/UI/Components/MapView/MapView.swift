import ReusableKit
import GoogleMaps

final class MapView: UIView, NibOwnerLoadable {
    @IBOutlet private weak var mapView: GMSMapView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }
}
