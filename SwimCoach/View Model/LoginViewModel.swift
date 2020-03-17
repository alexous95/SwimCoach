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
    
    enum LoginError: String {
        case fieldsError = " You need to fill correctly all the fields. Check if your password is longer than 5 or if your email is correct"
        case firebaseError = "Error while loading your profile, check your email or password"
    }
    
    @Published var isLoading: Bool = false
    @Published var access: Bool?
    
    var error: LoginError = .fieldsError
    
    func authentificate(withEmail email: String, password: String){
        isLoading = true
        if email == "" || password == "" || password.count < 5 {
            print("10")
            isLoading = false
            error = .fieldsError
            access = false
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    self.error = .firebaseError
                    self.access = false
                    self.isLoading = false
                    print(error.debugDescription)
                } else {
                    self.isLoading = false
                    self.access = true
                }
            }
        }
    }
}
