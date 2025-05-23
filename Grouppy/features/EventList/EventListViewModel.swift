//
//  GroupListViewModel.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/15.
//
import SwiftUI

class EventListViewModel: ObservableObject {
  private let repository: EventRepository
  @Published var searchMessage: String = ""
  @Published var eventList: [Event] = []

  init(repository: EventRepository = MockEventRepositoryImpl()) {
    self.repository = repository
    self.eventList = repository.fetchEvents()
  }

  var filteredEventList: [Event] {
    if searchMessage.isEmpty {
      return eventList
    } else {
      return eventList.filter {
        $0.title.contains(searchMessage) || $0.description.contains(searchMessage)
      }
    }
  }
}
