import ReusableKit
import Logger
import GoogleMaps
import UI

class MapView: GMSMapView, NibReusable {
    
    @IBOutlet weak private var touchView: TouchAnimatedView!
    
    override var selectedMarker: GMSMarker? {
        willSet {
            newValue?.select()
            selectedMarker?.deselect()
        }
    }
    
    // MARK: - Configuration methods

    func onDidLayoutSubviews() {
        bringSubviewToFront(touchView)
    }
    
    func didTouch(_ point: CGPoint) {
        touchView.drawTouch(point)
    }
    
    func deselectAll() {
        selectedMarker?.deselect()
    }
    
    func applyStyle() {
        applyMapStyle()
    }
    
    func setup() {
        isMyLocationEnabled = true
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

