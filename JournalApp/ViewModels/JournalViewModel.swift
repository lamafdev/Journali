import Foundation
import Observation

enum JournalSortOption {
    case bookmark
    case entryDate
}

@Observable
class JournalViewModel {
    
    var entries: [JournalEntry] = []
    var selectedSort: JournalSortOption = .entryDate
    func deleteEntry(id: UUID) {
        entries.removeAll { $0.id == id }
    }
    var sortedEntryIDs: [UUID] {
        sortedEntries.map(\.id)
    }
    var sortedEntries: [JournalEntry] {
        switch selectedSort {

        case .bookmark:
            return entries.sorted {
                if $0.isSaved != $1.isSaved {
                    return $0.isSaved && !$1.isSaved
                }
                return $0.date > $1.date
            }

        case .entryDate:
            return entries.sorted {
                $0.date > $1.date
            }
        }
    }

    func addEntry(_ entry: JournalEntry) {
        entries.append(entry)
    }
    
    var searchText: String = ""

    var filteredEntries: [JournalEntry] {
        guard !searchText.isEmpty else {
            return sortedEntries
        }

        return sortedEntries.filter { entry in
            entry.title.localizedCaseInsensitiveContains(searchText) ||
            entry.content.localizedCaseInsensitiveContains(searchText)
        }
    }

    var filteredEntryIDs: [UUID] {
        filteredEntries.map(\.id)
    }
}
