import Foundation

protocol EventUseCase {
  func fetchEvents() -> [Event]
  func fetchEvent(id: String) -> Event?
  func addEvent(_ event: Event)
}

class EventUseCaseImpl: EventUseCase {
  private let repository: EventRepository

  init(repository: EventRepository = MockEventRepositoryImpl()) {
    self.repository = repository
  }

  func fetchEvents() -> [Event] {
    repository.fetchEvents()
  }

  func fetchEvent(id: String) -> Event? {
    repository.fetchEvents().first(where: { $0.id == id })
  }

  func addEvent(_ event: Event) {
    repository.addEvent(event)
  }
}
