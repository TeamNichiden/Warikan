import Foundation
//
//  GroupViewModel.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/14.
//
import SwiftUI

class EventViewModel: ObservableObject {
  @Published var event: Event?
  private let repository: EventRepository
  private let eventId: String

  init(eventId: String, repository: EventRepository = MockEventRepositoryImpl()) {
    self.eventId = eventId
    self.repository = repository
    fetchEvent()
  }

  func fetchEvent() {
    event = repository.fetchEvents().first(where: { $0.id == eventId })
  }

  func addEvent(_ event: Event) {
    repository.addEvent(event)
    fetchEvent()
  }
}
