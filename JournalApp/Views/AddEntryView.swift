import SwiftUI

struct AddEntryView: View {
    
    @State private var title = ""
    @State private var content = ""
    @State private var journal = ""
    @State private var showDiscardConfirmation = false
    @FocusState private var isContentFocused: Bool
    @FocusState private var isTitleFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    var existingEntry: JournalEntry? = nil
    var onSave: (String, String) -> Void
    
    var body: some View {
        NavigationStack {
            
            
            VStack(spacing: 20) {
                
            
                
                HStack {
                    
                    Button {if let existingEntry {
                        if title != existingEntry.title || content != existingEntry.content {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                showDiscardConfirmation = true
                            }
                        } else {
                            dismiss()
                        }
                    } else if !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                              !content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            showDiscardConfirmation = true
                        }
                    } else {
                        dismiss()
                    }
                }
                    
                    label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                            .frame(width: 50, height: 50)
                            .glassEffect(
                                .regular.tint(
                                    Color(red: 0.100, green: 0.100, blue: 0.100, opacity: 1.00)                                        .opacity(0.5)
                                ),
                                in: .circle
                            )
                    }
                    
                    Spacer()
                    
                    Button {
                        
                        let finalTitle = title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                            ? "Untitled"
                            : title
                        
                        onSave(finalTitle, content)
                        dismiss()
                        
                    } label: {
                        Image(systemName: "checkmark")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(.black)
                            .frame(width: 45, height: 45)
                            .glassEffect(
                                .regular.tint(
                                    Color(red: 0.498, green: 0.506, blue: 1.000, opacity: 1.00)
                                ),
                                in: .circle
                            )
                    }
                    .disabled(
                        title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
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
                .focused($isTitleFocused)
                .tint(Color(red: 0.643, green: 0.601, blue: 1.000))
                
                Text(existingEntry?.date ?? Date(), format: .dateTime
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
                if let existingEntry {
                    title = existingEntry.title
                    content = existingEntry.content
                } else {
                    isTitleFocused = true
                }
            }
            
            
        }
        
        
        .overlay(alignment: .topLeading) {
            if showDiscardConfirmation {
                
                ZStack(alignment: .topLeading) {
                    
                    // Dim the editor behind the popup
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                showDiscardConfirmation = false
                            }
                        }
                    
                    // Discard confirmation popup
                    VStack(alignment: .leading, spacing: 14) {
                        
                        Text("Are you sure you want to discard changes on this journal?")
                            .font(.system(size: 16))
                            .foregroundStyle(.white.opacity(0.75))
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom, 6)
                            .padding(.leading, 6)
                        
                        Button {
                            dismiss()
                        } label: {
                            Text("Discard Changes")
                                .font(.system(size: 17))
                                .foregroundStyle(
                                    Color(red: 1, green: 0.23, blue: 0.23)
                                )
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                        }
                        .glassEffect(
                            .regular.tint(
                                Color(red: 0.22, green: 0.22, blue: 0.24)
                            ),
                            in: .capsule
                        )
                        
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                showDiscardConfirmation = false
                            }
                        } label: {
                            Text("Keep Editing")
                                .font(.system(size: 17))
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                        }
                        .glassEffect(
                            .regular.tint(
                                Color(red: 0.22, green: 0.22, blue: 0.24)
                            ),
                            in: .capsule
                        )
                    }
                    .buttonStyle(.plain)
                    .padding(20)
                    .frame(width: 300, height: 212)
                    // Dark translucent base
                    .background {
                        RoundedRectangle(cornerRadius: 32)
                            .fill(
                                Color(
                                    red: 0.07,
                                    green: 0.07,
                                    blue: 0.08
                                )
                                .opacity(0.45)
                            )
                    }
                    
                    // Apple's Liquid Glass
                    .glassEffect(
                        .regular.tint(
                            Color(red: 0.12, green: 0.12, blue: 0.13)
                        ),
                        in: .rect(cornerRadius: 32)
                    )
                    
                    // Subtle reflective border
                    .overlay {
                        RoundedRectangle(cornerRadius: 32)
                            .strokeBorder(
                                LinearGradient(
                                    colors: [
                                        .white.opacity(0.20),
                                        .white.opacity(0.03),
                                        .white.opacity(0.12)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 0.7
                            )
                            .allowsHitTesting(false)
                    }
                    
                    // Popup position below the drag indicator
                    
                    .padding(.leading, 12)  // Distance from left edge
                    .padding(.top, 20)      // Distance from top
                    .transition(
                        .opacity.combined(with: .scale(scale: 0.95))
                    )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .zIndex(10)
            }
        }
    }
}


