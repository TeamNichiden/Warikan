import Foundation

protocol AddEventUseCase {
  func addEvent(_ event: Event)
}

class AddEventUseCaseImpl: AddEventUseCase {
  private let repository: AddEventRepository

  init(repository: AddEventRepository = MockAddEventRepositoryImpl()) {
    self.repository = repository
  }

  func addEvent(_ event: Event) {
    repository.addEvent(event)
  }
}
