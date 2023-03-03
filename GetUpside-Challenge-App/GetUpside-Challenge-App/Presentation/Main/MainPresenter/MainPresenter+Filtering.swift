//
//  MainPresenter+Filtering.swift
//  GetUpside-Challenge-App
//
//  Created by Roman Vovk on 03.03.2023.
//

import FilterKit

extension Main.Presenter {
    struct Spec<T: Typable>: Specification {
        public typealias Item = T

        private let category: String

        init(_ category: String) {
            self.category = category
        }

        func isSatisfied(_ item: T) -> Bool {
            return item.type == category
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(category)
        }

        static func == (lhs: Spec, rhs: Spec) -> Bool {
            return lhs.category == rhs.category
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
