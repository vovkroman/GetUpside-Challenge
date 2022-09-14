import ReusableKit
import Logger
import GoogleMaps
import UIKit

class MapView: GMSMapView, NibReusable {
    
    override var selectedMarker: GMSMarker? {
        didSet {
            guard let selectedMarker = selectedMarker else { return }
            selectedMarker.selecte()
        }
    }
    
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

