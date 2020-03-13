//
//  User.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 05/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let email: String
    let password: String
    
    init(email: String = "", password: String = "") {
        self.email = email
        self.password = password
    }
}
