import RealmSwift

class RealmCoordinates: Object {
    @Persisted var longitude: Double = 0.0
    @Persisted var latitude: Double = 0.0
}

class RealmEatery: Object {
    @Persisted(primaryKey: true) var id = 0
    @Persisted var name: String
    @Persisted var category: String = ""
    @Persisted var location: RealmCoordinates?
}
