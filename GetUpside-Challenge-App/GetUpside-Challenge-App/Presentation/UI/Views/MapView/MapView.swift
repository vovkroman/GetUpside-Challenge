import ReusableKit
import Logger
import GoogleMaps
import UIKit


class MapView: GMSMapView, NibReusable {
    
    override var selectedMarker: GMSMarker? {
        willSet {
            newValue?.select()
            selectedMarker?.deselect()
        }
    }
    
    // MARK: - Configuration methods

    func deselectAll() {
        selectedMarker?.deselect()
    }
    
    func applyStyle() {
        applyMapStyle()
    }
}

private extension MapView {
    
    func applyMapStyle(withFilename name: String = "silver_GM_style", andType type: String = "json") {
        if let styleURL = Bundle.main.url(forResource: name, withExtension: type) {
            mapStyle = try? GMSMapStyle(contentsOfFileURL: styleURL)
        } else {
            Logger.error("Unable to find \(name).json")
        }
    }
}

