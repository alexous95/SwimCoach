//
//  Presence.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 18/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation

struct Presence: Codable {
    
    let date: Date
    let isPresent: Bool
    
    init(date: Date, isPresent: Bool) {
        self.date = date
        self.isPresent = isPresent
    }
}
