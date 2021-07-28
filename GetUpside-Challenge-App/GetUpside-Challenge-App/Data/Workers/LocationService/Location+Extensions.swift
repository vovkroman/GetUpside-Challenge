import Foundation
import CoreLocation

extension CLLocationCoordinate2D: Equatable {
    public static func == (
        lhs: CLLocationCoordinate2D,
        rhs: CLLocationCoordinate2D
    ) -> Bool {
        return lhs.latitude.isAlmostEqual(to: rhs.latitude) &&
            lhs.longitude.isAlmostEqual(to: rhs.longitude)
    }
}
