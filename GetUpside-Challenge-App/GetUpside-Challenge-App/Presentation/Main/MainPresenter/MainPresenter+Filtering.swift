//
//  MainPresenter+Filtering.swift
//  GetUpside-Challenge-App
//
//  Created by Roman Vovk on 03.03.2023.
//

import FilterKit

extension Main.Presenter {
    struct Spec<T: Categorized>: Specification {
        
        public typealias Item = T

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

        static func == (lhs: Spec, rhs: Spec) -> Bool {
            return lhs.id == rhs.id
        }
    }
}

extension Main.Presenter: FilterSupporting {
    func applyFilter(_ key: String) {
        executor.apply(Spec(key))
    }
    
    func removeFilter(_ key: String) {
        executor.remove(Spec(key))
    }
}
