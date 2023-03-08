import Foundation

extension Main.Presenter: MainPresenterSupporting {
    
    func onDataDidLoad(_ response: Main.Response) {
        display(convertToEateyViewModel(response.eateries))
        display(convertToFilterViewModels(response.filters))
    }
}

private extension Main.Presenter {
    
    func convertToFilterViewModels(_ models: Main.Filters) -> Filter.ViewModel {
        let converter = Convertor.FiltersViewModelConverter()
        return try! converter.convertFromTo(from: models)
    }
    
    func convertToEateyViewModel(_ models: Main.Eateries) -> [Main.ViewModel] {
        var viewModels: [Main.ViewModel] = []
        let converter = Convertor.EateryViewModelConverter()
        for model in executor.filter(models) {
            viewModels.append(try! converter.convertFromTo(from: model))
        }
        return viewModels
    }
}
