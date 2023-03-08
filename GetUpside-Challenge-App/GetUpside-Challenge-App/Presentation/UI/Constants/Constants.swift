import UIKit

extension UIFont {
    static var getUpsideTitle: UIFont {
        return UIFont(name: "American Typewriter", size: 100.0)!
    }
    
    static var getUpsideTitleHeader: UIFont {
        return UIFont(name: "American Typewriter", size: 80.0)!
    }
    
    static var getUpsideTitleBody: UIFont {
        return UIFont(name: "American Typewriter", size: 60.0)!
    }
}

enum Constant {
    enum SplashLogo {
        static let title: UIFont = UIFont.getUpsideTitle
        static let header: UIFont = UIFont.getUpsideTitleHeader
        static let body: UIFont = UIFont.getUpsideTitleBody
        
        static let strokeColor: UIColor = .red
        static let fillColor: UIColor = .clear
        static let lineWidth: CGFloat = 4.0
    }
    
    enum Animator {
        static let duration: TimeInterval = 1.72
    }
    
    enum Map {
        static let numberInCluster: Int = 2
        static let iconGenerator: Cluster.IconGenerator = Cluster.IconGenerator(
            buckets: [10, 30, 50, 70, 90, 130],
            backgroundImages: [
                ImageRenderer.render(MapRenderRequest.cluster(diameter: 70)),
                ImageRenderer.render(MapRenderRequest.cluster(diameter: 100)),
                ImageRenderer.render(MapRenderRequest.cluster(diameter: 120)),
                ImageRenderer.render(MapRenderRequest.cluster(diameter: 150)),
                ImageRenderer.render(MapRenderRequest.cluster(diameter: 190)),
                ImageRenderer.render(MapRenderRequest.cluster(diameter: 210))
            ]
        )
        enum Pin {
            static let size: CGSize = CGSize(width: 35.0, height: 50.0)
        }
    }
    
    enum Filter {
        static let height: CGFloat = 70.0
        static let padding: (dx: CGFloat, dy: CGFloat) = (dx: 16.0, dy: 4.0)
        static let size: CGSize = CGSize(50.0, 50.0)
        static let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 22),
            .foregroundColor: UIColor.black
        ]
    }
    
    enum Location {
        static let kCLDistanceHundredMeters: Double = 100.0
    }
}
