//
//  AddWorkoutLineViewModel.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 01/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
import Combine

class AddWorkoutViewModel {
    
    @Published var title: String = ""
    
    
    let now = Date()
    let dateFormatter = DateFormatter()
    
    var dateSelected: Date?
    var workoutLines: [WorkoutLine] = []
    
    func getNumberOfLines() -> Int {
        return workoutLines.count
    }
    
    func addWorkoutLine(_ workoutLine: WorkoutLine ) {
        workoutLines.append(workoutLine)
    }
    
    func addWorkout(title: String, date: String, for group: Group, to month: String) {
        FirestoreWorkoutManager().addWorkout(to: group, for: month, title: title, date: date, workoutLines: self.workoutLines)
    }
    
    
    func printDate() -> String {
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        dateFormatter.locale = Locale(identifier: "FR-fr")
        
        return dateFormatter.string(from: now)
    }
    
    /// Return the formatted date of the selected date
    func printDate(from date: Date) -> String {
        dateSelected = date
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "FR-fr")
        
        return dateFormatter.string(from: date)
    }
    
}
