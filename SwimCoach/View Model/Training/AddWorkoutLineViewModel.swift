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
    
    let network: NetworkWorkoutService
    var workoutLines: [WorkoutLine] = []
    
    init(network: NetworkWorkoutService = FirestoreWorkoutManager()) {
        self.network = network
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "FR-fr")
    }
    
    func getNumberOfLines() -> Int {
        return workoutLines.count
    }
    
    func createWorkout(title: String, date: String, for group: Group, for month: String) {
        let workout = Workout(title: title, date: date, workoutID: "")
        let id = network.addWorkout(to: group, for: month, workout: workout)
        workout.workoutID = id
        self.workout = workout
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
                network.addWorkoutLine(to: group, for: month, workoutID: workout.workoutID , workoutLine: workoutLine)
            }
            workout.workoutLines = workoutLines
        }
    }
    
    func printDate() -> String {
        
        return dateFormatter.string(from: now)
    }
    
    /// Return the formatted date of the selected date
    func printDate(from date: Date) -> String {
        dateSelected = date
        
        return dateFormatter.string(from: date)
    }
    
}
