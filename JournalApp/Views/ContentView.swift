import SwiftUI
import Playgrounds

struct ContentView: View {
    
    @State private var showMainPage = false
    
    var body: some View {
        
        
ZStack {
    
    if showMainPage {
        MainPage()
    } else {
        
        LinearGradient(
            colors: [
            Color(red: 0.00, green: 0.00, blue: 0.00),
            Color(red: 0.04, green: 0.035, blue: 0.055),
            Color(red: 0.09, green: 0.085, blue: 0.10)
                        ],
                    startPoint: .top,
                    endPoint: .bottom
                      )
                    .ignoresSafeArea()
                    
            VStack{
                        
                        
             Image(.journaliIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .ignoresSafeArea()
                        
             Text("Journali")
                .font(.system(size: 42, weight: .black ))
                .foregroundStyle(.white)
                .ignoresSafeArea()
                
             Text("Your thoughts, your story")
            .font(.system(size:20 , weight: .light ))
            .foregroundStyle(.white)

                  
            
            }    }

                

    }
        
.task {
    try? await Task.sleep(for: .seconds(3))

    guard !Task.isCancelled else { return }

    withAnimation(.easeInOut(duration: 0.6)) {
        showMainPage = true
    }
}
        
       
    }
}

#Preview {
    ContentView()
}

