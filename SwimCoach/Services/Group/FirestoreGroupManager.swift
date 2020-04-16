//
//  FirestoreManager.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 06/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirestoreGroupManager: NetworkGroupService {
    
    /// Fetch the documents from the group's collection
    /// - Parameter completion: An escaping closure of type ([Group], Error?) to pass data to another class
    /// We use this class to populate our model in the viewModel
    func fetchGroup(completion: @escaping ([Group], Error?) -> ()) {
        var groups = [Group]()
        
        DispatchQueue.main.async {
            guard let user = Auth.auth().currentUser else { return }
            let ref = FirestoreService.database.collection("users").document(user.uid)
            
            ref.collection("groups").getDocuments { (snapshot, error) in
                if error != nil {
                    completion(groups, error!)
                    return
                }
                
                guard let snapshot = snapshot else { return }
                let documents = snapshot.documents
                
                for document in documents {
                    guard let group = Group(document: document.data()) else { return }
                    groups.append(group)
                }
                completion(groups, nil)
            }
        }
    }
    
    /// Add a document to the group's collection
    /// - Parameter group: The object that will be added to the database
    ///
    /// The group model has a property dictionnary of type [String : Any] used to add data to firestore
    func addGroup(group: Group) {
        
        DispatchQueue.main.async {
            
            guard let user = Auth.auth().currentUser else { return }
            let ref = FirestoreService.database.collection("users").document(user.uid).collection("groups")
            
            // We create here a new document which name is the group name
            // We set the data with dictionnary property of the group model
            
            ref.document(group.groupName).setData(group.dictionnary)
        }
    }
    
    func deleteGroup(group: Group) {
        
        DispatchQueue.main.async {
            guard let user = Auth.auth().currentUser else { return }
            let ref = FirestoreService.database.collection("users").document(user.uid).collection("groups")
            
            let deleteRef = ref.document(group.groupName)
            
            deleteRef.delete { (error) in
                if error !=  nil {
                    print(error.debugDescription)
                }
            }
        }
    }
}
