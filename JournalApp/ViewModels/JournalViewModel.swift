import Foundation
import Observation

enum JournalSortOption {
    case bookmark
    case entryDate
}

@Observable
class JournalViewModel {
    
    var entries: [JournalEntry] = [] {
        didSet {
            saveEntries()
        }
    }
    
    private let storageKey = "savedJournalEntries"

    init() {
        loadEntries()
    }
    private func saveEntries() {
        do {
            let data = try JSONEncoder().encode(entries)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("Failed to save entries: \(error)")
        }
    }

    private func loadEntries() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else {
            return
        }

        do {
            entries = try JSONDecoder().decode([JournalEntry].self, from: data)
        } catch {
            print("Failed to load entries: \(error)")
        }
    }
    
    
    
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
    
    func updateEntry(id: UUID, title: String, content: String) {
        guard let index = entries.firstIndex(where: { $0.id == id }) else {
            return
        }

        entries[index].title = title
        entries[index].content = content
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
