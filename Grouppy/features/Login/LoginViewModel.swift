//
//  LoginViewModel.swift
//  Grouppy
//
//  Created by Yuki Imai on 2025/05/02.
//

import Combine
import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    func login(completion: @escaping (Bool) -> Void) {
        isLoading = true
        // TODO: 実際の認証処理を実装
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isLoading = false
            if self.email == "test@example.com" && self.password == "password" {
                completion(true)
            } else {
                self.errorMessage = "メールアドレスまたはパスワードが間違っています"
                completion(false)
            }
        }
    }
    
    // MARK: TEST
    func managerMode() {
        email = "test@example.com"
        password = "password"
    }
    
}
