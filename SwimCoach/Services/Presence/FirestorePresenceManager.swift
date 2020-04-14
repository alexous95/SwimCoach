//
//  FirestorePresenceManager.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 06/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class FirestorePresenceManager: NetworkPresenceService {
  
    
    /// Adds a presence to the database
    /// - Parameter personID: The person ID to select the correct document in the database
    /// - Parameter group: The group object that will be used to create our reference in the database
    /// - Parameter stringDate: A string representing our date to create a document
    func addPresence(personID: String, from group: Group, stringDate: String) {
        
        DispatchQueue.main.async {
            guard let user = Auth.auth().currentUser else { return }
            let ref = FirestoreService.database.collection("users").document(user.uid).collection("groups").document(group.groupName).collection("persons").document(personID)
            
            ref.updateData(["presences": FieldValue.arrayUnion([stringDate])])
        }
    }
    
    /// Fetches the presence for a person
    func fetchPresence(personID: String, from group: Group, completion: @escaping ([String], Error?) -> ()) {
        var presences: [String] = []
        
        DispatchQueue.main.async {
            guard let user = Auth.auth().currentUser else { return }
            let ref = FirestoreService.database.collection("users").document(user.uid).collection("groups").document(group.groupName).collection("persons").document(personID)
            
            ref.getDocument { (document, error) in
                if error != nil {
                    print("error while loading presences")
                    completion(presences, error)
                    return
                } else {
                    if let doc = document, doc.exists {
                        guard let person = Person(document: doc.data()!) else {
                            return
                        }
                        presences = person.presences
                        completion(presences, nil)
                        return
                    }
                }
                completion(presences, nil)
            }
        }
    }
}
