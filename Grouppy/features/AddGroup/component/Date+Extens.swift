//
//  Date.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/13.
//

import Foundation

extension Date {
    func dateToString(format: String = "yyyy/MM/dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: self)
    }
}
