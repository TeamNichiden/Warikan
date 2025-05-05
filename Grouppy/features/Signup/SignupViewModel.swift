//
//  SignupViewModel.swift
//  Grouppy
//
//  Created by Yuki Imai on 2025/05/02.
//

import Foundation

class SignupViewModel: ObservableObject {
    @Published var uiState: SignupUIState = SignupUIState()

    func validatePassword() -> Bool {
        return uiState.password == uiState.passwordConfirm && !uiState.password.isEmpty
    }
}
