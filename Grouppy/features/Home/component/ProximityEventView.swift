import SwiftUI

struct ProximityEventView: View {
    private let repository: EventInfoRepository = MockEventInfoRepositoryImpl()
    @EnvironmentObject var route: NavigationRouter
    
    private var recentEvents: [Event] {
        let allEvents = repository.fetchEvents()
        return EventUtils.getRecentThreeEvents(from: allEvents)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("最近のイベント")
                .font(.headline)
                .fontWeight(.bold)
            
            if recentEvents.isEmpty {
                Text("現在はイベントがありません")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
            } else {
                ForEach(recentEvents) { event in
                    proximityEventRow(for: event)
                }
            }
        }
        .padding(.vertical)
    }
    
    private func proximityEventRow(for event: Event) -> some View {
        Button(action: {
            route.navigate(to: .event(id: event.id))
        }) {
            HStack {
                Rectangle()
                    .fill(.yellow)
                    .frame(width: 5, height: 50)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.title)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    Text(event.updatedAt.dateToString())
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.leading, 8)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .font(.caption)
                    .padding(.trailing, 8)
            }
            .foregroundColor(.black)
            .background(Color(.systemGray6))
            .clipShape(
                .rect(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 8,
                    topTrailingRadius: 8
                )
            )
        }
    }
}

#Preview {
    ProximityEventView()
        .environmentObject(NavigationRouter())
}
