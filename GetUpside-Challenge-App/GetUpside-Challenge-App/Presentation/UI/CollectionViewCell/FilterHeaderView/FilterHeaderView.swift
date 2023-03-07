import UIKit
import ReusableKit


class FilterHeaderView: UICollectionReusableView, NibReusable {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.image = ImageRenderer.render(ConfigRenderRequest.sorting(size: CGSize(100.0, frame.height)))
        // Initialization code
    }
}
