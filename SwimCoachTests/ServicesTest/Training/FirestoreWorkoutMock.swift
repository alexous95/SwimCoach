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
    var databaseWorkout: [String : [String: [Workout]]]
    
    var emptyWorkoutLine = [WorkoutLine]()
    var databaseWorkoutLines: [String: [WorkoutLine]]
    
    init(databaseWorkout: [String : [String: [Workout]] ], databaseWorkoutLines: [String : [WorkoutLine]] ,error: Error? = nil) {
        self.databaseWorkout = databaseWorkout
        self.databaseWorkoutLines = databaseWorkoutLines
        self.error = error
    }
    
    func fetchWorkout(from group: Group, for month: String, completion: @escaping ([Workout], Error?) -> ()) {
        if error == nil {
            guard let workoutsTmp = databaseWorkout[group.groupName]?[month] else {
                completion(emptyWorkout, nil)
                return
            }
            var index = 0
            for workout in workoutsTmp {
                fetchWorkoutLines(from: group, for: month, for: workout.workoutID) { (workoutLine, error) in
                    self.databaseWorkout[group.groupName]?[month]?[index].workoutLines = workoutLine
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
            guard let workoutLineTmp = databaseWorkoutLines[workoutID] else {
                completion(emptyWorkoutLine, nil)
                return
            }
            completion(workoutLineTmp, nil)
        } else {
            completion(emptyWorkoutLine, error)
        }
    }
    
    func deleteWorkout(from group: Group, for month: String, workoutID: String) {
        guard let workouts = databaseWorkout[group.groupName]?[month] else {
            return
        }
        
        var index = 0
        for workout in workouts {
            if workout.workoutID == workoutID {
                databaseWorkout[group.groupName]?[month]?.remove(at: index)
                databaseWorkoutLines.removeValue(forKey: workoutID)
            }
            index += 1
        }
    }
    
    
    func addWorkout(to group: Group, for month: String, workout: Workout) -> String {
        if workout.workoutID == "" {
            let newWorkout = workout
            newWorkout.workoutID = "test"
            databaseWorkout[group.groupName]![month]!.append(newWorkout)
            return newWorkout.workoutID
        } else {
            var index = 0
            
            guard let workouts = databaseWorkout[group.groupName]?[month] else { return "" }
            for workoutList in workouts {
                if workoutList.workoutID == workout.workoutID {
                    databaseWorkout[group.groupName]?[month]?[index] = workout
                    databaseWorkoutLines[workout.workoutID] = workout.workoutLines
                    return workout.workoutID
                }
                index += 1
            }
            
            databaseWorkout[group.groupName]?[month]?.append(workout)
            return workout.workoutID
        }
    }
    
    func addWorkoutLine(to group: Group, for month: String, workoutID: String, workoutLine: WorkoutLine) {
        if workoutLine.workoutLineID == "" {
            let newWorkoutLine = workoutLine
            newWorkoutLine.workoutLineID = "testLine"
            databaseWorkoutLines[workoutID]?.append(newWorkoutLine)
        } else {
            var index = 0
            
            guard let workoutLines = databaseWorkoutLines[workoutID] else { return }
            for workoutLineList in workoutLines {
                if workoutLineList.workoutLineID == workoutLine.workoutLineID {
                    databaseWorkoutLines[workoutID]?[index] = workoutLine
                    return
                }
                index += 1
            }
            
            databaseWorkoutLines[workoutID]?.append(workoutLine)
        }
    }
    
    func deleteWorkoutLine(from group: Group, for month: String, workoutID: String, workoutLineID: String) {
        var index = 0
        
        let workoutLines = databaseWorkoutLines[workoutID]!
        
        for workoutLine in workoutLines {
            if workoutLineID == workoutLine.workoutLineID {
                databaseWorkoutLines[workoutID]?.remove(at: index)
            }
            index += 1
        }
    }
}
