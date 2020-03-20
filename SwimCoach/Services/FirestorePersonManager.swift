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
    
    
    static func addPerson(lastName: String, firstName: String, to group: Group) {
        
        if let user = Auth.auth().currentUser {
            let ref = FirestoreService.database.collection("users").document(user.uid).collection("groups").document(group.groupName).collection("persons")
            
            // We create an empty document and we retrieve his ID which is created randomly
            
            let id = ref.document().documentID
            let person = Person(personID: id, firstName: firstName, lastName: lastName)
            ref.document(id).setData(person.dictionary)
            
        }
    }
}

