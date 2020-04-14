//
//  FirestorePresenceMock.swift
//  SwimCoachTests
//
//  Created by Alexandre Goncalves on 14/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
@testable import SwimCoach

class FirestorePresenceMock: FirestorePresenceManager {
    
    var emptyPresence = [String]()
    var error: Error?
    var persons: [Person]
    
    init(persons: [Person], error: Error? = nil){
        self.persons = persons
        self.error = error
    }
    
    override func addPresence(personID: String, from group: Group, stringDate: String) {
        var index = 0
        
        for person in persons {
            if person.personID == personID {
                persons[index].presences.append(stringDate)
            }
            
            index += 1
        }
    }
    
    override func fetchPresence(personID: String, from group: Group, completion: @escaping ([String], Error?) -> ()) {
        if self.error == nil {
            var index = 0
            for person in persons {
                if person.personID == personID {
                    completion(person.presences, nil)
                }
                index += 1
            }
        } else {
            completion(emptyPresence, error)
        }
    }
}
