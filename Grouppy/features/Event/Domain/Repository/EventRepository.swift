import Foundation

protocol EventRepository {
  func fetchEvents() -> [Event]
  func addEvent(_ event: Event)
}

class MockEventRepositoryImpl: EventRepository {
  func fetchEvents() -> [Event] {
    MockData.events
  }
  func addEvent(_ event: Event) {
    MockData.events.append(event)
  }
}
