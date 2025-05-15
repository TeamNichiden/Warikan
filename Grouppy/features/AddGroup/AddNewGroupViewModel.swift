//
//  AddNewGroupViewModel.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/10.
//

import Foundation

class AddNewGroupViewModel:ObservableObject {
    @Published var mockGroup = MockGroupModel()
    @Published var isShowGroup: Bool = false
    @Published var selectedDate = Date()
    @Published var showDatePicker: Bool = false
    @Published var isCreating: Bool = false
    @Published var lastGroupId: UUID?
    @Published var group: MockGroupModel?
    
    func initialDate() {
        let today = Date()
        mockGroup.dateStr = today.dateToString(format: "yyyy年MM月dd日 HH時mm分")
    }
    
    func showCalendar() {
        showDatePicker = true
    }
    
    func updateDate() {
        mockGroup.dateStr = selectedDate.dateToString(format: "yyyy年MM月dd日 HH時mm分")
        showDatePicker = false
    }
    
    func showMap() {
        
    }
    
    func isCheckingInfo() {
        if !mockGroup.groupName.isEmpty {
            addGroup()
            isShowGroup = true
        }
    }
    
    func addGroup() {
        let newGroup = mockGroup
        MockGroupList.shared.groupList.append(newGroup)
        lastGroupId = newGroup.id
        mockGroup = MockGroupModel()
    }
}
