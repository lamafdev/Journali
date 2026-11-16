import SwiftUI

struct JournalToolbar: View {
    
    @State private var showSortMenu = false
    @Binding var selectedSort: JournalSortOption
    var onAdd: () -> Void
    
    var body: some View {

        HStack(spacing: 28) {

            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    showSortMenu.toggle()
                }
            } label: {
                Image(systemName: "line.3.horizontal.decrease")
            }
            .foregroundStyle(.white)
            
            
            Button {
                onAdd()
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(.white)
            }
        }
        .font(.system(size: 20))
        .foregroundStyle(.black)
        .padding(12)
        .glassEffect(
            .regular.tint(
                Color(red: 0.12, green: 0.12, blue: 0.13)
                    .opacity(1)
            ),
            in: .rect(cornerRadius: 24)
        )
        .transition(.opacity.combined(with: .scale(scale: 0.95)))
        .overlay(alignment: .topTrailing) {

            if showSortMenu {

                VStack(alignment: .leading, spacing: 0) {

                    Button {
                        selectedSort = .bookmark
                        showSortMenu = false
                    } label: {
                        Text("Sort by Bookmark")
                    }

                    Divider()
                        .padding(.vertical, 12)
                        .foregroundStyle(.white)

                    Button {
                        selectedSort = .entryDate
                        showSortMenu = false
                    } label: {
                        Text("Sort by Entry Date")
                    }
                }
                .font(.system(size: 16))
                .foregroundStyle(.white)
                .buttonStyle(.plain)
                .padding(20)
                .frame(width: 250, alignment: .leading)
                .glassEffect(
                    .regular.tint(
                        Color(red: 0.12, green: 0.12, blue: 0.13)
                            .opacity(1)
                    ),
                    in: .rect(cornerRadius: 24)
                )
                .offset(y: 55)
                .transition(.opacity.combined(with: .scale(scale: 0.95)))
                .zIndex(1)
            }
        }
    }
}

struct SearchToolbar: View {

    @Binding var searchText: String
    @State private var speechRecognizer = SpeechRecognizer()

    var body: some View {

        HStack(spacing: 12) {

            Image(systemName: "magnifyingglass")
                .font(.system(size: 26))
                .foregroundStyle(.white.opacity(0.5))
                .frame(width: 28, height: 28, alignment: .leading)

            TextField(
                "",
                text: $searchText,
                prompt: Text("Search")
                    .foregroundColor(.white.opacity(0.2))
                    .font(.system(size: 18))
                

            )

            Button {
                Task {
                    if speechRecognizer.isRecording {
                        speechRecognizer.stopRecording()
                    } else {
                        await speechRecognizer.startRecording()
                    }
                }
            } label: {
                Image(systemName: speechRecognizer.isRecording ? "mic.fill" : "mic")
                    .foregroundStyle(
                        speechRecognizer.isRecording ? .red : .white
                    )
            }
            .onChange(of: speechRecognizer.recognizedText) { _, newText in
                searchText = newText
            }
        }
        .font(.system(size: 18))
        .foregroundStyle(.white)
        .padding(.horizontal, 20)
        .frame(height: 56)
        .glassEffect(
            .regular.tint(
                Color(red: 0.12, green: 0.12, blue: 0.13)
                    .opacity(1)
            ),
            in: .capsule
        )
        
    }
}

#Preview {
    @Previewable @State var selectedSort: JournalSortOption = .entryDate

    ZStack {
        Color.black.ignoresSafeArea()

        JournalToolbar(
            selectedSort: $selectedSort,
            onAdd: {}
        )
    }
}
