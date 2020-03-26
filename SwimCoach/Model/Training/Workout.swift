//
//  Workout.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 26/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation

final class Workout {
    
    let title: String
    let date: String
    
    var zone1: Int = 0
    var zone2: Int = 0
    var zone3: Int = 0
    var zone4: Int = 0
    var zone5: Int = 0
    var zone6: Int = 0
    var zone7: Int = 0
    
    var distance: Int {
        get {
            return zone1 + zone2 + zone3 + zone4 + zone5 + zone6 + zone7
        }
    }
    
    var dictionnary: [String : Any] {
        return ["title" : self.title,
                "date" : self.date,
                "zone1" : self.zone1,
                "zone2" : self.zone2,
                "zone3" : self.zone3,
                "zone4" : self.zone4,
                "zone5" : self.zone5,
                "zone6" : self.zone6,
                "zone7" : self.zone7,
                "distance" : self.distance
               ]
    }
    
    init(title: String, date: String) {
        self.title = title
        self.date = date
    }
    
    func addZ1(distance: Int) {
        zone1 += distance
    }
    
    func addZ2(distance: Int) {
        zone2 += distance
    }
    
    func addZ3(distance: Int) {
        zone3 += distance
    }
    
    func addZ4(distance: Int) {
        zone4 += distance
    }
    
    func addZ5(distance: Int) {
        zone5 += distance
    }
    
    func addZ6(distance: Int) {
        zone6 += distance
    }
    
    func addZ7(distance: Int) {
        zone7 += distance
    }
    
}
