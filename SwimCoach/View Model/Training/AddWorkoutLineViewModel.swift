//
//  AddWorkoutLineViewModel.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 01/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation

class AddWorkoutLineViewModel {
    
    var title: String = ""
    let now = Date()
    let dateFormatter = DateFormatter()
    
    var workout: Workout?
    
    var dateSelected: Date?
    var workoutLines: [WorkoutLine] = []
    
    func getNumberOfLines() -> Int {
        return workoutLines.count
    }
    
    func addWorkoutLine(_ workoutLine: WorkoutLine ) {
        var index = 0
        for workout in workoutLines {
            if workout.workoutLineID == workoutLine.workoutLineID && workoutLine.workoutLineID != "" {
                workoutLines.remove(at: index)
                workoutLines.insert(workoutLine, at: index)
                return
            }
            index += 1
        }
        workoutLines.append(workoutLine)
    }
    
    func addLineToWorkout(to group: Group, for month: String) {
        if workout == nil {
            print("erreur add line workout")
            return
        } else {
            guard let workout = workout else { return }
            for workoutLine in workoutLines {
                FirestoreWorkoutManager().addWorkoutLine(to: group, for: month, workoutID: workout.workoutID , workoutLine: workoutLine)
            }
        }
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
