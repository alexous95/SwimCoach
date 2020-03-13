//
//  LoginViewModel.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 12/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
import Combine
import FirebaseAuth

final class LoginViewModel {
    
    @Published var isLoading: Bool = false
    
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func authentificate(withEmail email: String, password: String) -> Bool {
        isLoading = true
        if email == "" || password == "" || password.count < 5 {
            return false
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    print(error.debugDescription)
                } else {
                    self.isLoading = false
                }
            }
            return true
        }
    }
}
