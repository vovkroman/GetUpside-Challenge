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
        static let iconGenerator: Cluster.IconGenerator = Cluster.IconGenerator(buckets: [10, 25, 50, 100],
                                                                                backgroundImages: [
                                                                                    UIImage.circle(diameter: 60, color: .black),
                                                                                    UIImage.circle(diameter: 80, color: .darkGray),
                                                                                    UIImage.circle(diameter: 100, color: .gray),
                                                                                    UIImage.circle(diameter: 120, color: .lightGray)])
        enum Pin {
            static let size: CGSize = CGSize(width: 35, height: 40.0)
        }
    }
    
    enum Location {
        static let kCLDistanceHundredMeters: Double = 100.0
    }
}

let iconGenerator = Cluster.IconGenerator(buckets: [10, 25, 50, 100], backgroundImages: [
                                                                                   UIImage.circle(diameter: 60, color: .black),
                                                                                   UIImage.circle(diameter: 80, color: .darkGray),
                                                                                   UIImage.circle(diameter: 100, color: .gray),
                                                                                   UIImage.circle(diameter: 120, color: .lightGray)])
