import Foundation
import GoogleMapsUtils
import UIKit

extension Cluster {
    class IconGenerator: GMUDefaultClusterIconGenerator {}
}

extension Cluster {
    class Algorithm: GMUNonHierarchicalDistanceBasedAlgorithm {}
}

extension Cluster {
    class Renderer: GMUDefaultClusterRenderer {
        override func shouldRender(as cluster: GMUCluster, atZoom zoom: Float) -> Bool {
            return cluster.count >= 10
        }
    }
}

extension Cluster {
    class Manager: GMUClusterManager {}
}

