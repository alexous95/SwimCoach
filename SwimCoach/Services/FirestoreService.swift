//
//  FirestoreService.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 20/02/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
import Firebase

/// Class that holds our database reference
final class FirestoreService {
    
    /// The reference to our firestore databse
    static let database = Firestore.firestore()
    
}
