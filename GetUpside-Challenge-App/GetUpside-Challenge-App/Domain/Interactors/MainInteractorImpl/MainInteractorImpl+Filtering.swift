import Foundation

extension Main.InteractorImpl {
    
    func applyFillter(_ key: String) {
        presenter.applyFilter(key)
        onLoadDidFinish(eateries, [])
    }
    
    func removeFilter(_ key: String) {
        presenter.removeFilter(key)
        onLoadDidFinish(eateries, [])
    }
}
