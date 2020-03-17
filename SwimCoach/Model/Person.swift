//
//  Person.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 06/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation

struct Person: Codable {
     
    let firstName: String
    let lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }

}
