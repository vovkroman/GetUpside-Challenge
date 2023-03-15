import Foundation

extension Convertor {
    
    struct FiltersViewModelConverter: Convertable {
        typealias From = [Filter.Model]
        typealias To = Filter.ViewModel
        
        let isInitialConfig: Bool
        
        func convertFromTo(from: [Filter.Model]) throws -> Filter.ViewModel {
            var cellsConfigurators: [Filter.CellConfigurator] = []
            var indexPathes: [IndexPath] = []
            for item in from {
                cellsConfigurators.append(makeCellConfigurator(item, .category(item.description)))
                indexPathes.append(IndexPath(row: item.idx, section: 0))
            }
            if isInitialConfig {
                let numerOfModels = from.count
                cellsConfigurators.append(makeCellConfigurator(Filter.Model("near me (20 km)", numerOfModels + 1), .nearMe))
                return .inital(cells: cellsConfigurators,
                               headerConfig: makeHeader("Filter: ")
                )
            }
            return .update(cellConfigs: Filter.CellConfigurators(indexPathes: indexPathes, cells: cellsConfigurators))
        }
        
        func convertToFrom(from: Filter.ViewModel) throws -> [Filter.Model] {
            throw Error.convertFailed(context: "Could't convert item from \(Filter.ViewModel.self) to \([Filter.Model].self)")
        }
        
        init(_ isInitialConfig: Bool) {
            self.isInitialConfig = isInitialConfig
        }
    }
}

private extension Convertor.FiltersViewModelConverter {
    
    func makeCellConfigurator(_ item: Filter.Model, _ type: Filter.`Type`) -> Filter.CellConfigurator {
        let filter = Constant.Filter.self
        let attributes = filter.attributes
        let padding = filter.padding
        
        let size = CGSize(.infinity, filter.height)
        return Filter.CellConfigurator { builer in
            let attributedString = NSAttributedString(string: item.description, attributes: attributes)
            let rect = attributedString.boundingRect(with: size, options: [], context: nil)
            
            builer.attributedString = attributedString
            builer.type = type
            builer.size = CGSize(rect.width + padding.dx, rect.height + padding.dy)
        }
    }
    
    func makeHeader(_ title: String) -> NSAttributedString {
        return NSAttributedString(string: title)
    }
}
