//
//  HideKeyboard+extens.swift
//  Grouppy
//
//  Created by cmStudent on 2025/05/14.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}
