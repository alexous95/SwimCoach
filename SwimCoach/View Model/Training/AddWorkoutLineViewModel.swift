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
        print("WorkoutLine id: \(workoutLine.workoutLineID)")
        for workout in workoutLines {
            print("WourkoutLines id : \(workout.workoutLineID)")
            if workout.workoutLineID == workoutLine.workoutLineID {
                workoutLines.remove(at: index)
                workoutLines.insert(workoutLine, at: index)
                return
            }
            index += 1
        }
        workoutLines.append(workoutLine)
    }
    
    func addNewWorkout(title: String, date: String, for group: Group, to month: String) {
        if workout == nil {
            workout = Workout(title: title, date: date, workoutID: "", workoutLines: self.workoutLines)
            guard let workout = workout else { return }
            
            FirestoreWorkoutManager().addWorkout(to: group, for: month, workout: workout, workoutLines: workoutLines)
        } else {
            guard let workout = workout else { return }
        
            FirestoreWorkoutManager().addWorkout(to: group, for: month, workout: workout, workoutLines: workoutLines)
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
