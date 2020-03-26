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
    let workoutID: String
    
    var workoutLines: [WorkoutLine] = []
    
    init(title: String, date: String, workoutID: String = "") {
        self.title = title
        self.date = date
        self.workoutID = workoutID
    }
    
    var dictionnary: [String : Any] {
        return ["title" : self.title,
                "date" : self.date,
                "workoutID" : self.workoutID
               ]
    }
    
    convenience init?(document: [String : Any]) {
        guard let title = document["title"] as? String else { return nil }
        guard let date = document["date"]  as? String else { return nil }
        guard let workoutID = document["workoutID"] as? String else { return nil }
        self.init(title: title, date: date, workoutID: workoutID)
    }
    
    func addLine(_ workoutLine: WorkoutLine) {
        workoutLines.append(workoutLine)
    }
    
    func getDistance() -> String {
        var distance = 0.0
        for workout in workoutLines {
            distance += workout.getDistance()
        }
        
        return String(distance)
    }
    
}
