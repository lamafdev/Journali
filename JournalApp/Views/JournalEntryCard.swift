import SwiftUI

struct JournalEntryCard: View {

    @Binding var entry: JournalEntry
    
    var body: some View {

        VStack(alignment: .leading, spacing: 0) {

            HStack(alignment: .top) {

                VStack(alignment: .leading, spacing: 6) {

                    Text(entry.title)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(
                            Color(red: 0.686, green: 0.600, blue: 0.992)
                        )

                    Text(entry.date, format: .dateTime.day().month().year())
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                }

                Spacer()

                Button {
                    entry.isSaved.toggle()
                } label: {
                    Image(systemName: entry.isSaved ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 24))
                        .foregroundStyle(
                            Color(red: 0.686, green: 0.600, blue: 0.992)
                        )
                }
                .buttonStyle(.plain)
            }

            Text(entry.content)
                .font(.system(size: 18))
                .foregroundStyle(.white)
                .lineLimit(5)
                .padding(.top, 22)
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color(red: 0.115, green: 0.115, blue: 0.12)
        )
        .clipShape(RoundedRectangle(cornerRadius: 28))
    }
}


#Preview {
    @Previewable @State var entry = JournalEntry(
        title: "Today's Journal",
        content: "Today I learned SwiftUI!",
        date: Date()
    )

    JournalEntryCard(entry: $entry)
        .padding()
}
