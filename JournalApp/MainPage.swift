import SwiftUI
import Playgrounds
struct MainPage: View {
    
@State private var searchText = ""
@State private var entries: [String] = []
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
                    
        HStack(spacing:20){
         Button{
                            
            //action later
                            
                } label: {
            Image(systemName: "line.3.horizontal.decrease")
                   }
                        
        Button{
                            
            //action later
                            
                } label : {
                        Image(systemName: "plus")
                    }
            
            }
            .font(.system(size: 20))
            .foregroundStyle(.white)
            .padding(12)
            .background(Color(red: 0.150, green: 0.150, blue: 0.150, opacity: 1.00))
            .clipShape(RoundedRectangle(cornerRadius: 100))
            .overlay {
                    Capsule()
            .strokeBorder(
                    LinearGradient(
                    stops: [
                        .init(color: .white.opacity(0.3), location: 0),
                        .init(color: .gray.opacity(0.15), location: 0.25),
                        .init(color: .black.opacity(0.05), location: 0.5),
                        .init(color: .gray.opacity(0.2), location: 0.75),
                        .init(color: .white.opacity(0.3), location: 1)
                            ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            
                            )
                    }
                    
            }
                .padding(.horizontal, 20 )
                .padding(.top, 1)
                
                
                Spacer()
         
        if entries.isEmpty {
            
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
        
        else{
            
            ScrollView{
                LazyVStack{
                    
                    
                    
                }
                
            }
          }
         
                
                Spacer()
             
                

      }
   
     
    }
 .overlay(alignment: .bottom){
     
  
     HStack(spacing: 14) {

         Image(systemName: "magnifyingglass")
             .font(.system(size: 27, weight: .regular))
             .foregroundStyle(Color.gray)

         TextField("Search", text: $searchText)
             .font(.system(size: 24))
             .tint(.white)
             .foregroundStyle(.white)

         Button {
             // Microphone action
         } label: {
             Image(systemName: "mic")
                 .font(.system(size: 25))
                 .foregroundStyle(Color.gray)
         }
     }
     .padding(.horizontal, 18)
     .frame(height: 58)
     .background(
         Color(red: 0.105, green: 0.105, blue: 0.105)
     )
     .clipShape(Capsule())
     .overlay {
         Capsule()
             .stroke(
                 LinearGradient(
                     colors: [
                         .gray.opacity(0.45),
                         .gray.opacity(0.08),
                         .gray.opacity(0.3)
                     ],
                     startPoint: .topLeading,
                     endPoint: .bottomTrailing
                 ),
                 lineWidth: 1
             )
     }
     .padding(.horizontal, 18)

 }
        
        

        

        
       
}
}

#Preview {
    MainPage()
}


