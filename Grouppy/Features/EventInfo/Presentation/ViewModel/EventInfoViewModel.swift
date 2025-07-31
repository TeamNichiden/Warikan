import Foundation
//
//  EventInfoViewModel.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/14.
//
import SwiftUI

class EventInfoViewModel: ObservableObject {
  @Published var event: Event?
  private let repository: EventInfoRepository
  private let eventId: String

  init(eventId: String, repository: EventInfoRepository = MockEventInfoRepositoryImpl()) {
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
