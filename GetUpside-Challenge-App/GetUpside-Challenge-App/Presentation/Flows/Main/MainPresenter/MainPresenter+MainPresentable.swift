import Foundation

extension Main.Presenter: MainPresenterSupporting {
    
    func onDataDidLoad(_ response: Main.Response) {
        display(convertToEateyViewModel(response.eateries))
        display(convertToFilterViewModels(response.filters))
    }
    
    func onLoading() {
        guard let view = view else { return }
        queue.async(execute: combine(with: view.onLoading))
    }
}

private extension Main.Presenter {
    
    func convertToFilterViewModels(_ models: Main.Filters) -> Filter.ViewModel {
        let converter = Convertor.FiltersViewModelConverter()
        return try! converter.convertFromTo(from: models)
    }
    
    func convertToEateyViewModel(_ models: [Eatery]) -> [Main.ViewModel] {
        var viewModels: [Main.ViewModel] = []
        let converter = Convertor.EateryViewModelConverter()
        for model in models {
            // used try! as it never throw an exeption
            viewModels.append(try! converter.convertFromTo(from: model))
        }
        return viewModels
    }
}
