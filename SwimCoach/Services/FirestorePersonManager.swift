//
//  FirestorePersonManager.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 18/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
import FirebaseAuth

final class FirestorePersonManager {
    
    /// Fetches persons belonging to a group from the database
    /// - Parameter group: A Group object to get our reference from firebase
    /// - Parameter completion: An escaping closure to transmit the data to another class
    ///
    /// We use this method with a group name to create a path to our required group.
    /// We then fetch all the document inside the persons collection from the document groupName.
    static func fetchPersons(from group: Group, completion: @escaping ([Person], Error?) -> ()) {
        var persons = [Person]()
        
        if let user = Auth.auth().currentUser {
            let ref = FirestoreService.database.collection("users").document(user.uid).collection("groups").document(group.groupName).collection("persons")
            
            ref.getDocuments { (snapshot, error) in
                if error != nil {
                    print("An error occured while loading the persons")
                    completion(persons, error)
                    return
                } else {
                    guard let snapshot = snapshot else { return }
                    let documents = snapshot.documents
                    
                    for document in documents {
                        guard let person = Person(document: document.data()) else { return }
                        persons.append(person)
                    }
                    completion(persons, nil)
                }
            }
        }
    }
    
    
    /// Adds a person to the database
    /// - Parameter lastName: The person's last name
    /// - Parameter firstName: The person's first name
    /// - Parameter group: The group object that will be used to create our reference in the database
    ///
    /// We use this method with a group name to create a path to our required group.
    /// We then create a person object and a new document in the "persons" collection
    /// Finaly we add the person to the database
    static func addPerson(lastName: String, firstName: String, to group: Group) {
        if let user = Auth.auth().currentUser {
            let ref = FirestoreService.database.collection("users").document(user.uid).collection("groups").document(group.groupName).collection("persons")
            
            // We create an empty document and we retrieve his ID which is created randomly
            
            let id = ref.document().documentID
            let person = Person(personID: id, firstName: firstName, lastName: lastName)
            ref.document(id).setData(person.dictionary)
            
        }
    }
    
    /// Deletes a person from the database
    /// - Parameter personID: The personID to select the correct document in the database
    /// - Parameter group: The group object that will be used to create our reference in the database
    ///
    /// We use this method with a group name and the personID to create a path to our required group.
    /// Then we delete the person's document to remove the data from the database
    static func deletePerson(personID: String, from group: Group) {
        if let user = Auth.auth().currentUser {
            let ref = FirestoreService.database.collection("users").document(user.uid).collection("groups").document(group.groupName).collection("persons")
            
            let deleteRef = ref.document(personID)
            
            deleteRef.delete { (error) in
                if error !=  nil {
                    print("Error while deleting")
                    print(error.debugDescription)
                } else {
                    print("Deletion succesful")
                }
            }
        }
    }
}

