import Foundation

protocol AddEventRepository {
  func addEvent(_ event: Event)
}

class MockAddEventRepositoryImpl: AddEventRepository {
  func addEvent(_ event: Event) {
    MockData.events.append(event)
  }
}
