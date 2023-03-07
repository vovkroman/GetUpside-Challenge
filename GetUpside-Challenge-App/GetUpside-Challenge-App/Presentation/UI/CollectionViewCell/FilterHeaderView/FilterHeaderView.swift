import UIKit
import ReusableKit

class FilterHeaderView: UICollectionReusableView, NibReusable {
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(_ configurator: Filter.HeaderConfigurator) {
        imageView.image = configurator.image
    }
}
