import SwiftUI

struct AddEntryView: View {

    @State private var title = ""
    @State private var content = ""
    @State private var journal = ""
    @FocusState private var isContentFocused: Bool
    @Environment(\.dismiss) private var dismiss

    var onSave: (String, String) -> Void

    var body: some View {
        NavigationStack {
            
            
            VStack(spacing: 20) {
                
                HStack {

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                            .frame(width: 50, height: 50)
                            .glassEffect(
                                .regular.tint(
                                    Color(red: 0.100, green: 0.100, blue: 0.100, opacity: 1.00)                                        .opacity(0.7)
                                ),
                                in: .circle
                            )                    }

                    Spacer()

                    Button {
                        onSave(title, content)
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(.black)
                            .frame(width: 50, height: 50)
                            .glassEffect(
                                .regular.tint(
                                    Color(red: 0.498, green: 0.506, blue: 1.000, opacity: 1.00)
                                ),
                                in: .circle
                            )
                    }
                    .disabled(
                        title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                        content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                    )
                }

                TextField(
                    "",
                    text: $title,
                    prompt: Text("Title")
                        .foregroundColor(Color(red: 0.244, green: 0.244, blue: 0.244, opacity: 1.00))
                )
                .font(.system(size: 34, weight: .bold))
                .foregroundStyle(.white)
                .tint(Color(red: 0.643, green: 0.601, blue: 1.000))
                
                Text(Date(), format: .dateTime
                    .day(.twoDigits)
                    .month(.twoDigits)
                    .year()
                    .locale(Locale(identifier: "en_GB"))
                )
                    .font(.system(size: 16))
                    .foregroundStyle(Color(red: 0.639, green: 0.604, blue: 0.604, opacity: 1.00))
                    .frame(maxWidth: .infinity, alignment: .leading)

                
                TextEditor(text: $content)
                    .focused($isContentFocused)
                    .font(.system(size: 18))
                    .foregroundStyle(.white)
                    .scrollContentBackground(.hidden)
                    .tint(Color(red: 0.643, green: 0.601, blue: 1.000))
                    .overlay(alignment: .topLeading) {
                        if content.isEmpty {
                            Text("Type Your Journal...")
                                .font(.system(size: 18))
                                .foregroundStyle(Color(red: 0.244, green: 0.244, blue: 0.244, opacity: 1.00))
                                .padding(.top, 8)
                                .padding(.leading, 5)
                                .allowsHitTesting(false)
                        }
                    }

                Spacer()
            }
            .padding(20)
            .background(Color(red: 0.110, green: 0.110, blue: 0.118, opacity: 1.00).ignoresSafeArea())
            .foregroundStyle(.white)
            .task {
                isContentFocused = true
            }
            
        }
        .preferredColorScheme(.dark)
    }
}


