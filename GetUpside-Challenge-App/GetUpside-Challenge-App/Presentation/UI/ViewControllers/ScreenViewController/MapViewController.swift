import UIKit

final class MapViewController: BaseViewController<MapView>{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.setupMapStyle()
    }
}
