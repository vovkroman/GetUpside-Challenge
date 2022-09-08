import UIKit
import GoogleMaps
import GoogleMapsUtils

final class MapViewController: BaseViewController<MapView> {
    
    var clusterManager: Cluster.Manager!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.applyStyle()
    }
    
    func update(with items: [Main.ViewModel]) {
        for viewModel in items {
            let marker = GMSMarker(position: viewModel.coordinates)
            marker.tracksViewChanges = false
            marker.title = viewModel.name
            marker.appearAnimation = .pop
            clusterManager.add(marker)
        }
        clusterManager.cluster()
    }
    
    // MARK: - Private methods
    
    required init(_ clusterManager: Cluster.Manager) {
        self.clusterManager = clusterManager
        super.init()
    }
    
    required init() {
        super.init()
    }
}

extension MapViewController: ChildUpdatable {
    
}
