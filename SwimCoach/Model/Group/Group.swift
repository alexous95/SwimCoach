//
//  Group.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 06/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation

struct Group: Codable {
    
    let groupName: String
    
    var dictionnary: [String : Any] {
        return ["groupName" : self.groupName]
    }
    
    init(groupName: String) {
        self.groupName = groupName
    }
    
    init?(document: [String: Any]) {
        guard let groupName = document["groupName"] as? String else { return nil }
        
        self.init(groupName: groupName)
    }
}
