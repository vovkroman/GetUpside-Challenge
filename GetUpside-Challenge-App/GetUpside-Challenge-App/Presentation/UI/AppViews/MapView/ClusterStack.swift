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
    class SizeResolver {
        //define number of cluster where index is specific zoom
        let zooms: [Float]
        let clusters: [Int]
        
        // define appropriate cluster size depands on current zoom (using binary search)
        func resolve(_ zoom: Float) -> Int {
            var index = 0
            let n = zooms.count
            var steps = n / 2
            while steps >= 1 {
                while index + steps < n, zooms[index + steps] <= zoom {
                    index += steps
                }
                steps /= 2
            }
            return clusters[index]
        }
        
        init(_ zooms: [Float], _ clusters: [Int]) {
            if clusters.count != zooms.count {
                fatalError("Clusters and zooms size should be the same")
            }
            self.zooms = zooms
            self.clusters = clusters
        }
    }
}

extension Cluster {
    final class Renderer: GMUDefaultClusterRenderer {
        
        let sizeResolver: SizeResolver
        
        override func shouldRender(as cluster: GMUCluster, atZoom zoom: Float) -> Bool {
            return cluster.count >= sizeResolver.resolve(zoom)
        }
        
        init(mapView: GMSMapView, clusterIconGenerator iconGenerator: GMUClusterIconGenerator, clusterSizeResolver: SizeResolver) {
            self.sizeResolver = clusterSizeResolver
            super.init(mapView: mapView, clusterIconGenerator: iconGenerator)
        }
    }
}

extension Cluster {
    final class Manager: GMUClusterManager, ClusterManagerSupporting {}
} 
