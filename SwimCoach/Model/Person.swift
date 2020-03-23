//
//  Person.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 06/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation

struct Person: Codable {
     
    let personID: String
    let firstName: String
    let lastName: String
    
    init(personID: String = "", firstName: String, lastName: String) {
        self.personID = personID
        self.firstName = firstName
        self.lastName = lastName
    }
    
    var dictionary: [String : Any] {
        return ["personID": self.personID,
                "firstName": self.firstName,
                "lastName": self.lastName
                ]
    }
    
    init?(document: [String : Any]) {
        guard let personID = document["personID"] as? String else { return nil }
        guard let firstName = document["firstName"] as? String else { return nil }
        guard let lastName = document["lastName"] as? String else { return nil }
        
        self.init(personID: personID, firstName: firstName, lastName: lastName)
    }

}
