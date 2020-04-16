//
//  FirestoreWorkoutMock.swift
//  SwimCoachTests
//
//  Created by Alexandre Goncalves on 16/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
@testable import SwimCoach

final class FirestoreWorkoutMock: NetworkWorkoutService {

    var error: Error?
    
    var emptyWorkout = [Workout]()
    var databaseWorkout: [String : [String: [Workout]] ]
    
    var emptyWorkoutLine = [WorkoutLine]()
    var databaseWorkoutLines: [String: [WorkoutLine]]?
    
    init(databaseWorkout: [String : [String: [Workout]] ], error: Error? = nil) {
        self.databaseWorkout = databaseWorkout
        self.error = error
    }
    
    func fetchWorkout(from group: Group, for month: String, completion: @escaping ([Workout], Error?) -> ()) {
        if error == nil {
            guard let workoutsTmp = databaseWorkout[group.groupName]![month] else {
                completion(emptyWorkout, nil)
                return
            }
            var index = 0
            for workout in workoutsTmp {
                fetchWorkoutLines(from: group, for: month, for: workout.workoutID) { (workoutLine, error) in
                    self.databaseWorkout[group.groupName]![month]![index].workoutLines = workoutLine
                }
                
                index += 1
            }
            
            let workouts = databaseWorkout[group.groupName]![month]!
            completion(workouts, nil)
        } else {
            completion(emptyWorkout, error)
        }
    }
    
    func fetchWorkoutLines(from group: Group, for month: String, for workoutID: String, completion: @escaping ([WorkoutLine], Error?) -> () ){
        if error == nil {
            guard let workoutLineTmp = databaseWorkoutLines![workoutID] else {
                completion(emptyWorkoutLine, nil)
                return
            }
            completion(workoutLineTmp, nil)
        } else {
            completion(emptyWorkoutLine, error)
        }
    }
    
    func deleteWorkout(from group: Group, for month: String, workoutID: String) {
        let workouts = databaseWorkout[group.groupName]![month]!
        
        for workout in workouts {
            
        }
    }
    
    
    func addWorkout(to group: Group, for month: String, workout: Workout) -> String {
        if workout.workoutID == "" {
            let newWorkout = workout
            newWorkout.workoutID = "test"
            databaseWorkout[group.groupName]![month]!.append(newWorkout)
            return newWorkout.workoutID
        } else {
            databaseWorkout[group.groupName]![month]!.append(workout)
            return workout.workoutID
        }
    }
    
    func addWorkoutLine(to group: Group, for month: String, workoutID: String, workoutLine: WorkoutLine) {
        if workoutLine.workoutLineID == "" {
            let newWorkoutLine = workoutLine
            newWorkoutLine.workoutLineID = "testLine"
            databaseWorkoutLines![workoutID]?.append(newWorkoutLine)
        } else {
            databaseWorkoutLines![workoutID]?.append(workoutLine)
        }
    }
    
    func deleteWorkoutLine(from group: Group, for month: String, workoutID: String, workoutLineID: String) {
        var index = 0
        
        let workoutLines = databaseWorkoutLines![workoutID]!
        
        for workoutLine in workoutLines {
            if workoutLineID == workoutLine.workoutLineID {
                databaseWorkoutLines![workoutID]!.remove(at: index)
            }
            index += 1
        }
    }
}
