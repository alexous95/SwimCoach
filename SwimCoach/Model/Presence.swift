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
    
    var dictionnary: [String: Any] {
        return ["date": self.date,
                "isPresent": self.isPresent
               ]
    }
    
    init?(document: [String : Any]) {
        guard let date = document["date"] as? Date else { return nil }
        guard let isPresent = document["isPresent"] as? Bool else { return nil }
        
        self.init(date: date, isPresent: isPresent)
    }
}
