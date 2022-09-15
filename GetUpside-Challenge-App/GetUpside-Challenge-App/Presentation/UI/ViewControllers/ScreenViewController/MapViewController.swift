import UIKit
import Logger
import GoogleMaps
import GoogleMapsUtils

final class MapViewController: BaseViewController<MapView> {
    
    var clusterManager: ClusterManagerSupporting!
        
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setup()
    }
    
    // MARK: - Private API
    
    private func _setup() {
        contentView.applyStyle()
        contentView.delegate = self
    }
    
    // MARK: - Init methods
    
    required init(_ clusterManager: ClusterManagerSupporting) {
        self.clusterManager = clusterManager
        super.init()
    }
    
    required init() {
        super.init()
    }
}

extension MapViewController: GMSMapViewDelegate {
    
}

extension MapViewController: ChildUpdatable {
    
    func update<ViewModel: Main.ViewModelable>(_ viewModels: [ViewModel]) {
        for viewModel in viewModels {
            let marker = GMSMarker(position: viewModel.coordinates)
            
            let image = viewModel.image
            let imageView = UIImageView(image: image)
            let rect = CGRect(center: imageView.center, size: image.size)
            let iconView = PinIconView(frame: rect)
            
            iconView.addSubview(imageView)
            
            imageView.frame = CGRect(center: imageView.center, size: image.size)
            
            marker.iconView = iconView
            marker.snippet = viewModel.name
            
            marker.appearAnimation = .pop
            clusterManager.add(marker)
        }
        clusterManager.cluster()
    }
}
