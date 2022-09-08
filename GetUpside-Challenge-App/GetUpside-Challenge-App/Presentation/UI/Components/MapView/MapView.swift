import ReusableKit
import Logger
import GoogleMaps

class MapView: GMSMapView, NibReusable {
    
    // MARK: - Configuration methods

    func applyStyle() {
        _applyMapStyle()
    }
}

private extension MapView {
    
    func _applyMapStyle(withFilename name: String = "silver_GM_style", andType type: String = "json") {
        if let styleURL = Bundle.main.url(forResource: name, withExtension: type) {
            mapStyle = try? GMSMapStyle(contentsOfFileURL: styleURL)
        } else {
            Logger.error("Unable to find \(name).json")
        }
    }
}
