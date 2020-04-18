//
//  DatabaseMock.swift
//  SwimCoachTests
//
//  Created by Alexandre Goncalves on 18/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
@testable import SwimCoach

class DatabaseMock {
    
    var emptyWorkoutLine = [WorkoutLine]()
    var databaseWorkout = [String : [String: [Workout]]]()
    var databaseWorkoutLines =  [String: [WorkoutLine]]()
    var error: Error?
    var group: Group = Group(groupName: "")
    var workout = Workout(title: "", date: "", workoutID: "", workoutLines: [])
    
    enum DatabaseError: Error {
        case empty
    }
    
    func createWorkoutLines() -> [WorkoutLine] {
        let workoutLine = WorkoutLine(text: "test", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID", workoutLineTitle: "titleTest")
        
        let workoutLine2 = WorkoutLine(text: "test2", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID2", workoutLineTitle: "titleTest2")
        
        let workoutLines = [workoutLine, workoutLine2]
        
        return workoutLines
    }
    
    private func createWorkouts() -> [Workout] {
        
        let workoutLines = createWorkoutLines()
        var databaseWorkoutLines = [String : [WorkoutLine]]()
        
        var workouts = [Workout]()
        
        for index in 0...2 {
            let workout = Workout(title: "testTitle" + "\(index)", date: "testDate" + "\(index)", workoutID: "testID" + "\(index)", workoutLines: workoutLines)
            workouts.append(workout)
            
            databaseWorkoutLines[workout.workoutID] = workoutLines
        }
        
        return workouts
    }

    private func createWorkoutDatabase() -> [String : [String : [Workout]]] {
        let workout = createWorkouts()
        
        let databaseWorkout = ["Arctique" : ["April" : workout]]
        
        return databaseWorkout
    }
    
    private func createWorkoutLinesDatabase() -> [String: [WorkoutLine]] {
        
        let workoutLines = createWorkoutLines()
        var databaseWorkoutLines = [String : [WorkoutLine]]()
        
        for index in 0...2 {
            databaseWorkoutLines["testID" + "\(index)"] = workoutLines
        }
        
        return databaseWorkoutLines
    }
    
    private func createGroup() -> Group {
        return Group(groupName: "Arctique")
    }
    
    private func createError() -> DatabaseError {
        return .empty
    }
    
    private func fetchWorkout() -> Workout {
        return (databaseWorkout["Arctique"]?["April"]?[0])!
    }
    
    func initDatabase() {
        databaseWorkout = createWorkoutDatabase()
        databaseWorkoutLines = createWorkoutLinesDatabase()
        error = createError()
        group = createGroup()
        workout = fetchWorkout()
    }
}
