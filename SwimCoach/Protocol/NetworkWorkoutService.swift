//
//  NetworkWorkoutService.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 06/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation

/// Protocol used for dependency injection
///
/// We use this protocol to fetch, add and delete workouts from the database
protocol NetworkWorkoutService {
    func fetchWorkout(from group: Group, for month: String, completion: @escaping ([Workout], Error?) -> ())
    func fetchWorkoutLines(from group: Group, for month: String, for workoutID: String, completion: @escaping ([WorkoutLine], Error?) -> () )
    func addWorkout(to group: Group, for month: String, workout: Workout) -> String
    func addWorkoutLine(to group: Group, for month: String, workoutID: String, workoutLine: WorkoutLine)
    func deleteWorkout(from group: Group, for month: String, workoutID: String)
    func deleteWorkoutLine(from group: Group, for month: String, workoutID: String, workoutLineID: String)
}
