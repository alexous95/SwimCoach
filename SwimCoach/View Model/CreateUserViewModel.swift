//
//  CreateUserViewModel.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 16/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
import FirebaseAuth

final class CreateUserViewModel {
    
    enum CreateError: String {
        case incorrectField = "Check if your email is correct or if your password is longer than 5 or if your username is longer than 4"
        case firebaseError = "Error while creating your account"
    }
    
    @Published var isLoading: Bool = false
    @Published var access: Bool?
    
    var error: CreateError = .incorrectField
    
    func createUser(withUsername username: String, email: String, password: String) {
        
        isLoading = true
        if email == "" || password == "" || password.count < 5 || username.count < 4 {
            isLoading = false
            error = .incorrectField
            access = false
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                if error != nil {
                    self.isLoading = false
                    self.error = .firebaseError
                    self.access = false
                    print(error.debugDescription)
                } else {
                    self.isLoading = false
                    print("inscription de \(username)")
                    
                    guard let user = Auth.auth().currentUser else { return }
                    let userID = user.uid
                    
                    FirestoreService.database.collection("users").document(userID).setData(["username": username])
                    self.access = true                }
            }
        }
        
    }
}
