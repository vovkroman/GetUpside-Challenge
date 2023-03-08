//
//  MainPresenter+Filtering.swift
//  GetUpside-Challenge-App
//
//  Created by Roman Vovk on 03.03.2023.
//

import FilterKit

extension Main.Presenter {
    
    struct DistanceSpec<T: CoordinatesSupporting>: Specification {
        
        typealias Item = T
        
        private let currLocation: CurrentLocation
        private let radius: Double
        
        func isSatisfied(_ item: T) -> Bool {
            let (latitude, longitude) = (item.coordinates.latitude, item.coordinates.longitude)
            let itemLocation = CurrentLocation(latitude: latitude, longitude: longitude)
            return currLocation.distance(from: itemLocation) <= radius
        }
        
        init(_ coordinates: Coordinates, _ radius: Double) {
            self.radius = radius
            self.currLocation = CurrentLocation(
                latitude: coordinates.latitude,
                longitude: coordinates.longitude
            )
        }
    }
    
    struct CategorySpec<T: Categorized>: Specification {
        
        typealias Item = T

        private let id: String

        init(_ id: String) {
            self.id = id
        }

        func isSatisfied(_ item: T) -> Bool {
            return item.categoryId == id
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

        static func == (lhs: CategorySpec, rhs: CategorySpec) -> Bool {
            return lhs.id == rhs.id
        }
    }
}

extension Main.Presenter: FilterSupporting {
    func applyFilter(_ key: String) {
        executor.apply(CategorySpec(key))
    }
    
    func removeFilter(_ key: String) {
        executor.remove(CategorySpec(key))
    }
}
