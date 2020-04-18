//
//  Group.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 06/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation

struct Group: Codable {
    
    // MARK: - Variables
    
    /// The group's name
    let groupName: String
    
    /// Stored property that is used to add objects to Firestore
    var dictionnary: [String : Any] {
        return ["groupName" : self.groupName]
    }
    
    // MARK: - Init
    
    init(groupName: String) {
        self.groupName = groupName
    }
    
    init?(document: [String: Any]) {
        guard let groupName = document["groupName"] as? String else { return nil }
        
        self.init(groupName: groupName)
    }
}
