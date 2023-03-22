import RealmSwift

class RealmCoordinates: Object {
    @Persisted var longitude: Double = .nan
    @Persisted var latitude: Double = .nan
}

class RealmEatery: Object {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var name: String
    @Persisted var category: String = ""
    @Persisted var coordinates: RealmCoordinates?
}
