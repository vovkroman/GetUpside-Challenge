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
    
    enum Location {
        static let kCLDistanceHundredMeters: Double = 100.0
    }
}
