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
    let persons: [Person]
}
