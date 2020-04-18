//
//  AddWorkoutLineViewModel.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 01/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation

class AddWorkoutLineViewModel {
    
    // MARK: - Variables
    
    /// Property that holds our line title
    var title: String = ""
    
    /// The date of the day
    let now = Date()
    
    /// The formatter to display date
    let dateFormatter = DateFormatter()
    
    /// The workout that will be saved later to the databse
    var workout: Workout?
    
    /// The selected date that is updated from the controller
    var dateSelected: Date?
    
    /// Dependency injection
    ///
    /// We mock this property to test our code
    let network: NetworkWorkoutService
    
    // An array that stores our lines
    var workoutLines: [WorkoutLine] = []
    
    // MARK: - Init
    
    init(network: NetworkWorkoutService = FirestoreWorkoutManager()) {
        self.network = network
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "FR-fr")
    }
    
    /// Return the number of lines
    func getNumberOfLines() -> Int {
        return workoutLines.count
    }
    
    /// Creates a workout
    ///
    /// - Parameter title: The workout's title
    /// - Parameter date: The date of the workout
    /// - Parameter group: The group we want to add the workout to
    /// - Parameter month: The month we want to add the workout to
    ///
    /// We call this functions if the workout property is nil
    func createWorkout(title: String, date: String, for group: Group, for month: String) {
        let workout = Workout(title: title, date: date, workoutID: "")
        let id = network.addWorkout(to: group, for: month, workout: workout)
        workout.workoutID = id
        self.workout = workout
    }
    
    // MARK: - Database Functions
    
    /// Add a workoutLine to the workoutLines property
    /// - Parameter workoutLine: The workoutLine we want to add
    ///
    /// If the workoutLine already exists in the array we then update its value
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
    
    /// Add the workoutLines to the workout
    /// - Parameter group: The group we want to add the lines to
    /// - Parameter month: The month we want to add the lines to
    ///
    /// We use the network property to add the lines to the database
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
    
    // MARK: - Date Prints
    /// Prints the date of the day
    func printDate() -> String {
        
        return dateFormatter.string(from: now)
    }
    
    /// Return the formatted date of the selected date
    func printDate(from date: Date) -> String {
        dateSelected = date
        
        return dateFormatter.string(from: date)
    }
    
}
