import SwiftUI
import Playgrounds
struct MainPage: View {
    
@State private var searchText = ""
@State private var viewModel = JournalViewModel()
@State private var showAddEntry = false
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
            ScrollView {
                LazyVStack(spacing: 20) {

                    ForEach(viewModel.sortedEntryIDs, id: \.self) { id in

                        if let index = viewModel.entries.firstIndex(where: { $0.id == id }) {
                            JournalEntryCard(entry: $viewModel.entries[index])
                        }
                    }

                }
                .padding(.horizontal, 20)
                .padding(.bottom, 100)
            }
            .padding(.top,30)
        }
         
                
                Spacer()
        
        

             
       
                

      }
   
     
    }
 .overlay(alignment: .bottom) {
     
     SearchToolbar(searchText: $searchText)
         .padding(.horizontal, 20)
         .padding(.bottom, 12)
     
         .sheet(isPresented: $showAddEntry) {
             AddEntryView { title, content in

                 let newEntry = JournalEntry(
                     title: title,
                     content: content,
                     date: Date()
                 )

                 viewModel.addEntry(newEntry)
             }
         }
     
 }
        

        

        
       
}
}

#Preview {
    MainPage()
}


