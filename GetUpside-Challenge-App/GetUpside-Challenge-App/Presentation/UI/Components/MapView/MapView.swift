import ReusableKit
import Logger
import GoogleMaps

private extension GMSMapView {
    
    func mapStyle(withFilename name: String = "silver_GM_style", andType type: String = "json") {
        if let styleURL = Bundle.main.url(forResource: name, withExtension: type) {
            mapStyle = try? GMSMapStyle(contentsOfFileURL: styleURL)
        } else {
            Logger.error("Unable to find \(name).json")
        }
    }
}

final class MapView: UIView, NibReusable {
    @IBOutlet private weak var _mapView: GMSMapView!

    // MARK: - Configuration methods
    
    func setupMapStyle() {
        _mapView.mapStyle()
    }
}
