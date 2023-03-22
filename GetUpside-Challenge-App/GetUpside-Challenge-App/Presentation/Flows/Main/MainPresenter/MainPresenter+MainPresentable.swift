import Foundation

extension Main.Presenter: MainPresenterSupporting {
    
    func onChangeLocation(_ coordinates: Coordinates) {
        view?.onLocationDidChange(coordinates)
    }
    
    
    func onDataDidLoad(_ response: Main.Response, _ isInitial: Bool) {
        let eateries = response.eateries
        if !eateries.isEmpty {
            display(convertToEateyViewModel(eateries))
        }
        
        let filters = response.filters
        if !filters.isEmpty {
            display(convertToFilterViewModels(filters, isInitial))
        }
    }
    
    func onLoading() {
        guard let view = view else { return }
        queue.async(execute: combine(with: view.onLoading))
    }
}

private extension Main.Presenter {
    
    func convertToFilterViewModels(_ models: [Filter.Model], _ isInitial: Bool) -> Filter.ViewModel {
        let converter = Convertor.FiltersViewModelConverter(isInitial)
        return try! converter.convertFromTo(from: models)
    }
    
    func convertToEateyViewModel(_ models: [Main.Model]) -> [Main.ViewModel] {
        var viewModels: [Main.ViewModel] = []
        let converter = Convertor.EateryViewModelConverter()
        for model in models {
            // used try! as it never throw an exeption
            viewModels.append(try! converter.convertFromTo(from: model))
        }
        return viewModels
    }
}
