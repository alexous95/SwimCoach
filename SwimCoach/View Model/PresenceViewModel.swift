//
//  PresenceViewModel.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 18/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
import Combine

final class PresenceViewModel {
    
    
    var persons: [Person]?
    var group: Group
    var error: String = ""
    
    @Published var dataAvaillable: Bool = false
    @Published var isLoading: Bool = false
    
    init(group: Group) {
        self.group = group
    }
    
    /// Fetches persons from the database and add them to our model
    func fetchPerson() {
        isLoading = true
        FirestorePersonManager.fetchPersons(from: group) { (persons, error) in
            if error != nil {
                print("error while loading group")
                self.error = "error while loading"
                self.isLoading = false
                return 
            } else {
                self.persons = persons
                self.dataAvaillable = true
                self.isLoading = false
                self.dataAvaillable = false
            }
        }
    }
    
    /// Adds a person to the database and fetches the data to update the model
    func addPerson(lastName: String, firstName: String, to group: Group) {
        FirestorePersonManager.addPerson(lastName: lastName, firstName: firstName, to: group)
        fetchPerson()
    }
    
    /// Deletes a person from the database and fetches the data to udpdate the model
    func deletePerson(personID: String, from group: Group) {
        FirestorePersonManager.deletePerson(personID: personID, from: group)
        fetchPerson()
    }
    
}
