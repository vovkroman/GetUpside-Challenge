import Foundation
import GoogleMapsUtils
import UIKit

protocol ClusterManagerSupporting: AnyObject {
    func add(_ item: GMUClusterItem)
    func clearItems()
    func cluster()
}

extension Cluster {
    final class IconGenerator: GMUDefaultClusterIconGenerator {}
}

extension Cluster {
    // used a QuadTree
    class Algorithm: GMUNonHierarchicalDistanceBasedAlgorithm {}
}

extension Cluster {
    final class Renderer: GMUDefaultClusterRenderer {
        override func shouldRender(as cluster: GMUCluster, atZoom zoom: Float) -> Bool {
            return cluster.count >= Constant.Map.numberInCluster
        }
    }
}

extension Cluster {
    final class Manager: GMUClusterManager, ClusterManagerSupporting {}
} 
