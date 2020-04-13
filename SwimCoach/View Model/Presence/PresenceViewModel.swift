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
    
    private let networkPerson: NetworkPersonService
    private let networkPresence: NetworkPresenceService
    var group: Group
    
    var error: String = ""
    var dateSelected: Date?
    
    let now = Date()
    let dateFormatter = DateFormatter()
    
    @Published var dataAvaillable: Bool = false
    @Published var isLoading: Bool = false
    @Published var presenceAvaillable: Bool = false
    
    init(group: Group, networkPerson: NetworkPersonService = FirestorePersonManager(), networkPresence: NetworkPresenceService = FirestorePresenceManager()) {
        self.group = group
        self.networkPerson = networkPerson
        self.networkPresence = networkPresence
    }
    
    /// Fetches persons from the database and add them to our model
    func fetchPerson() {
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "FR-fr")
        
        var dateChoice = now
        if let dateSelected = dateSelected {
            dateChoice = dateSelected
        }
        let dateString = dateFormatter.string(from: dateChoice)
        isLoading = true
        networkPerson.fetchPersons(from: group, date: dateString) { (persons, error) in
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
    /// - Parameter lastName: The person's last name
    /// - Parameter firstName: The person's first name
    /// - Parameter group: The group object to create our reference
    ///
    /// This method calls a method from our service class that manage database operations
    func addPerson(lastName: String, firstName: String, to group: Group) {
        networkPerson.addPerson(lastName: lastName, firstName: firstName, to: group)
        fetchPerson()
    }
    
    /// Deletes a person from the database and fetches the data to udpdate the model
    /// - Parameter personID: The person's ID to get the correct document in the database
    /// - Parameter group: The group object to creat our reference
    ///
    /// This method calls a method from our service class that manage database operations
    func deletePerson(personID: String, from group: Group) {
        networkPerson.deletePerson(personID: personID, from: group)
        fetchPerson()
    }
    
    /// Returns the formatted date of the day
    ///
    /// - Returns: A string with the date of the day formatted
    func printDate() -> String {
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        dateFormatter.locale = Locale(identifier: "FR-fr")
        
        return dateFormatter.string(from: now)
    }
    
    /// Return the formatted date of the selected date
    func printDate(from date: Date) -> String {
        dateSelected = date
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "FR-fr")
        
        return dateFormatter.string(from: date)
    }
    
    /// Add a presence to the database
    func addPresence(personID: String, from group: Group, isPresent: Bool) {
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "FR-fr")
        
        if dateSelected == nil {
            let dateString = dateFormatter.string(from: now)
            networkPresence.addPresence(personID: personID, from: group, stringDate: dateString)
            fetchPerson()
        } else {
            guard let dateSelected = dateSelected else { return }
            let dateString = dateFormatter.string(from: dateSelected)
            networkPresence.addPresence(personID: personID, from: group, stringDate: dateString)
            fetchPerson()
        }
    }
    
    /// Returns a boolean indicating if the switch is supposed to be on or off
    /// - Parameter person: We need a person to access to its array of presences
    func switchState(person: Person) -> Bool {
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "FR-fr")
        
        for date in person.presences {
            if dateSelected != nil {
                guard let dateSelected = dateSelected else { return false }
                if date == dateFormatter.string(from: dateSelected) {
                    return true
                }
            } else {
                if date == dateFormatter.string(from: now) {
                    return true
                }
            }
        }
        return false
    }
}
