import UI
import GoogleMaps
import GoogleMapsUtils

protocol LocatingDelegate: AnyObject {
    func onLocatingDidChage(_ component: UIViewController, _ coordinate: Coordinates)
}

final class MapComponent: BaseComponent<MapView> {
    
    var clusterManager: ClusterManagerSupporting!
    weak var delegate: LocatingDelegate?
        
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onLoaded()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        onLayoutSubviews()
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

extension MapComponent {
    
    private func onLayoutSubviews() {
        contentView.onDidLayoutSubviews()
    }
    
    private func onLoaded() {
        contentView.setup()
        contentView.delegate = self
        contentView.applyStyle()
    }
}

extension MapComponent: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let touchPoint = mapView.projection.point(for: coordinate)
        contentView.didTouch(touchPoint)
        delegate?.onLocatingDidChage(self, coordinate)
    }
}

extension MapComponent: Component {
    
    func onLoading() {
        /// Nothing to do
    }
    
    func onDisplay<ViewModel: Main.ViewModelable>(_ viewModels: [ViewModel]) {
        typealias PinIconImage = IconView
        clusterManager.clearItems()
        for viewModel in viewModels {
            let marker = GMSMarker(position: viewModel.coordinates)
            
            let image = viewModel.image
            let pinIconView = PinIconImage(image: image)
            marker.iconView = pinIconView
            
            marker.snippet = viewModel.name
            
            marker.appearAnimation = .pop
            clusterManager.add(marker)
        }
        clusterManager.cluster()
    }
}
