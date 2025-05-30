//
//  AddNewEventViewModel.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/10.
//

import Foundation

class AddNewEventViewModel: ObservableObject {
    @Published var event = Event(
        id: UUID().uuidString,
        title: "",
        description: "",
        date: Date().dateToString(),
        place: "",
        ownerId: "",
        participantIds: [],
        transactions: [],
        createdAt: Date(),
        updatedAt: Date()
    )
    @Published var isShowEvent: Bool = false
    @Published var lastEventId: String?
    private let repository: EventInfoRepository
    
    init(repository: EventInfoRepository = MockEventInfoRepositoryImpl()) {
        self.repository = repository
    }
    
    func isCheckingInfo() {
        if !event.title.isEmpty {
            addEvent()
            isShowEvent = true
        }
    }
    
    func addEvent() {
        let newEvent = event
        repository.addEvent(newEvent)
        lastEventId = newEvent.id
        event = Event(
            id: UUID().uuidString,
            title: "",
            description: "",
            date: Date().dateToString(),
            place: "",
            ownerId: "",
            participantIds: [],
            transactions: [],
            createdAt: Date(),
            updatedAt: Date()
        )
    }
}
