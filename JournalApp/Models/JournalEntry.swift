import Foundation

struct JournalEntry: Identifiable {

    let id = UUID()

    var title: String
    var content: String
    var date: Date
    var isSaved: Bool = false
}
