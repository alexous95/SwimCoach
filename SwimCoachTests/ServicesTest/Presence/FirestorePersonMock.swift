//
//  FirestorePersonMock.swift
//  SwimCoachTests
//
//  Created by Alexandre Goncalves on 14/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
@testable import SwimCoach

final class FirestorePersonMock: NetworkPersonService {
    
    var emptyPersons: [Person] = []
    var error: Error?
    var database: [String : [Person]]
    
    init(database: [String : [Person]], error: Error? = nil) {
        self.database = database
        self.error = error
    }
    
    func fetchPersons(from group: Group, completion: @escaping ([Person], Error?) -> ()) {
        if error == nil {
            guard let person = database[group.groupName] else {
                completion(emptyPersons, nil)
                return
            }
            completion(person, nil)
        } else {
            completion(emptyPersons, error)
        }
    }
    
    func addPerson(lastName: String, firstName: String, to group: Group) {
        database[group.groupName]?.append(Person(firstName: firstName, lastName: lastName))
    }
    
    func deletePerson(personID: String, from group: Group) {
        var index = 0
        for person in database[group.groupName]! {
            if person.personID == personID {
                database[group.groupName]!.remove(at: index)
            }
            index += 1
        }
    }
}
