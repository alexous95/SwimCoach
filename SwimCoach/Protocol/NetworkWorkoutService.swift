//
//  NetworkWorkoutService.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 06/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation

protocol NetworkWorkoutService {
    func fetchWorkout(from group: Group, for month: String, completion: @escaping ([Workout], Error?) -> ())
    func fetchWorkoutLines(from group: Group, for month: String, for workoutID: String, completion: @escaping ([WorkoutLine], Error?) -> () )
     func deleteWorkout(from group: Group, for month: String, workoutID: String)
}
