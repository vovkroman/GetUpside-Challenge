import Foundation

extension Main.InteractorImpl {
    
    func applyFillter(_ key: String) {
        if key == "near me (20 km)" {
            requestLocation()
            return
        }
        presenter.applyFilter(key)
        onLoadDidFinish(eateries, [])
    }
    
    func removeFilter(_ key: String) {
        if key == "near me (20 km)" {
            return
        }
        presenter.removeFilter(key)
        onLoadDidFinish(eateries, [])
    }
}
