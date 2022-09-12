import Foundation
import GoogleMapsUtils
import UIKit

protocol ClusterManagerSupporting: AnyObject {
    func add(_ item: GMUClusterItem)
    func cluster()
}

extension Cluster {
    final class IconGenerator: GMUDefaultClusterIconGenerator {}
}

extension Cluster {
    class Algorithm: GMUNonHierarchicalDistanceBasedAlgorithm {}
}

extension Cluster {
    final class Renderer: GMUDefaultClusterRenderer {
        override func shouldRender(as cluster: GMUCluster, atZoom zoom: Float) -> Bool {
            return cluster.count >= 10
        }
    }
}

extension Cluster {
    final class Manager: GMUClusterManager, ClusterManagerSupporting {}
}

