//
//  FirestorePersonMock.swift
//  SwimCoachTests
//
//  Created by Alexandre Goncalves on 14/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
@testable import SwimCoach

class FirestorePersonMock: FirestorePersonManager {
    
    var emptyPersons: [Person] = []
    var error: Error?
    var persons: [Person]
    
    init(persons: [Person], error: Error? = nil) {
        self.persons = persons
        self.error = error
    }
    
    override func fetchPersons(from group: Group, date: String, completion: @escaping ([Person], Error?) -> ()) {
        
    }
    
    override func addPerson(lastName: String, firstName: String, to group: Group) {
        
    }
    
    override func deletePerson(personID: String, from group: Group) {
        
    }
}
