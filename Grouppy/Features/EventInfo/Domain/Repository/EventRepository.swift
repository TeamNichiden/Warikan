import Foundation

protocol EventInfoRepository {
  func fetchEvents() -> [Event]
  func addEvent(_ event: Event)
}

class MockEventInfoRepositoryImpl: EventInfoRepository {
  func fetchEvents() -> [Event] {
    MockData.events
  }
  func addEvent(_ event: Event) {
    MockData.events.append(event)
  }
}
