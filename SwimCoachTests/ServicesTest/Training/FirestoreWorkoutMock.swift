//
//  FirestoreWorkoutMock.swift
//  SwimCoachTests
//
//  Created by Alexandre Goncalves on 16/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
@testable import SwimCoach

final class FirestoreWorkoutMock: FirestoreWorkoutManager {
    
    var error: Error?
    
    var emptyWorkout = [Workout]()
    var databaseWorkout: [String : [String: Workout]]
    
    var databaseWorkoutLines: [String: [WorkoutLine]]?
    
    init(databaseWorkout: [String : [String: Workout]], error: Error? = nil) {
        self.databaseWorkout = databaseWorkout
        self.error = error
    }
    
    override func fetchWorkout(from group: Group, for month: String, completion: @escaping ([Workout], Error?) -> ()) {
        
    }
    
    override func fetchWorkoutLines(from group: Group, for month: String, for workoutID: String, completion: @escaping ([WorkoutLine], Error?) -> () ){
        
    }
    
    override func deleteWorkout(from group: Group, for month: String, workoutID: String) {
        
    }
}
