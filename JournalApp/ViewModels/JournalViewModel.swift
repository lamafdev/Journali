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
}
