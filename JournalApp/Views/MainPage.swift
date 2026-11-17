import SwiftUI
import Playgrounds
struct MainPage: View {
    
@State private var searchText = ""
@State private var viewModel = JournalViewModel()
@State private var showAddEntry = false
@State private var entryToDelete: UUID?
@State private var entryToEdit: JournalEntry?
    var body: some View {
        
 ZStack{
            
    Color(.black)
    .ignoresSafeArea()
            
            
    VStack{
                
     HStack{
                    
        Text("Journal")
        .font(.system(size: 34, weight: .bold ))
        .foregroundStyle(.white)
        .ignoresSafeArea()
                    
        Spacer()
         
         JournalToolbar(
             selectedSort: $viewModel.selectedSort,
             onAdd: {
                 showAddEntry = true
             }
         )           }
                .padding(.horizontal, 20 )
                .padding(.top, 1)
                .zIndex(1)
                
                
                Spacer()
         
        if viewModel.entries.isEmpty {
            Image(.emptyIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 151.39, height: 97.32)
                .ignoresSafeArea()
            
            
            
            Text("Begin Your Journal")
                .font(.system(size: 24, weight: .bold ))
                .foregroundStyle(Color(red: 0.686, green: 0.600, blue: 0.992, opacity: 1.00))
                .ignoresSafeArea()
                .padding()
            
            
            
            Text("Craft your personal diary, tap the\n plus icon to begin")
                .font(.system(size: 18, weight: .regular ))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
          
            
                           }
        
        else {
            List {
                ForEach(viewModel.filteredEntryIDs, id: \.self) { id in
                    if let index = viewModel.entries.firstIndex(where: { $0.id == id }) {

                  JournalEntryCard(entry: $viewModel.entries[index])
                            .listRowInsets(
                                EdgeInsets(
                                    top: 10,
                                    leading: 20,
                                    bottom: 8,
                                    trailing: 18)
                         )
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button(role: .destructive) {
                                    entryToDelete = id
                                } label: {
                                    Label("", systemImage: "trash")
                                }

                            }
                            .onTapGesture {
                                entryToEdit = viewModel.entries[index]
                            }
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            .padding(.top,20)
        }
         
                
                Spacer()
        
        

             
       
                

      }
   
     
    }
 .overlay(alignment: .bottom) {
     
     SearchToolbar(searchText: $viewModel.searchText)     .padding(.horizontal, 20)
         .padding(.bottom, 12)
     
         .sheet(isPresented: $showAddEntry) {
             AddEntryView { title, content in
                 viewModel.addEntry(
                     JournalEntry(
                         title: title,
                         content: content,
                         date: Date()
                     )
                 )
             }
             .presentationDragIndicator(.visible)
         }
         .sheet(item: $entryToEdit) { entry in
             AddEntryView(
                 existingEntry: entry,
                 onSave: { title, content in
                     viewModel.updateEntry(
                         id: entry.id,
                         title: title,
                         content: content
                     )
                 }
             )
             .presentationDragIndicator(.visible)
         }
         .alert(
             "Delete Journal?",
             isPresented: Binding(
                 get: { entryToDelete != nil },
                 set: { if !$0 { entryToDelete = nil } }
             )
         ) {
             Button("Cancel", role: .cancel) {
                 entryToDelete = nil
             }

             Button("Delete", role: .destructive) {
                 if let id = entryToDelete {
                     viewModel.deleteEntry(id: id)
                 }
                 entryToDelete = nil
             }
         } message: {
             Text("Are you sure you want to delete this journal?")
                 .multilineTextAlignment(.center)

         }
         .preferredColorScheme(.dark)
     
     
 }
        

        

        
       
}
}

#Preview {
    MainPage()
}


