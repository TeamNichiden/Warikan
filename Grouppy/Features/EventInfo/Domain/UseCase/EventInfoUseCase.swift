import Foundation

protocol EventInfoUseCase {
  func fetchEvents() -> [Event]
  func fetchEvent(id: String) -> Event?
  func addEvent(_ event: Event)
}

class EventInfoUseCaseImpl: EventInfoUseCase {
  private let repository: EventInfoRepository

  init(repository: EventInfoRepository = MockEventInfoRepositoryImpl()) {
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
