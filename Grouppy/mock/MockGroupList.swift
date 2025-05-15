//
//  MockGroupList.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/15.
//
import Foundation

class MockGroupList {
    static let shared = MockGroupList()
    
    private init() {}
    
    var groupList: [MockGroupModel] = []
}
