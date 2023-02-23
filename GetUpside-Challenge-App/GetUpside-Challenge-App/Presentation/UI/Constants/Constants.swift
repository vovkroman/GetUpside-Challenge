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
        static let iconGenerator: Cluster.IconGenerator = Cluster.IconGenerator(
            buckets: [10, 25, 50, 100],
            backgroundImages: [
                UIImage.circle(60, .black),
                UIImage.circle(80, .darkGray),
                UIImage.circle(100, .gray),
                UIImage.circle(120, .lightGray)
            ]
        )
        enum Pin {
            static let size: CGSize = CGSize(width: 40, height: 50.0)
        }
    }
    
    enum Filter {
        static let height: CGFloat = 70.0
        static let padding: (dx: CGFloat, dy: CGFloat) = (dx: 8.0, dy: 1.0)
        static let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 24),
            .foregroundColor: UIColor.black
        ]
    }
    
    enum Location {
        static let kCLDistanceHundredMeters: Double = 100.0
    }
}
