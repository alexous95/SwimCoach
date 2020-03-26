//
//  FirestoreWorkoutManager.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 26/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
import FirebaseAuth

final class FirestoreWorkoutManager {
    
    static func fetchWorkout(from group: Group, for month: String, completion: @escaping ([Workout], Error?) -> ()) {
        var workouts = [Workout]()
        
        if let user = Auth.auth().currentUser {
            let ref = FirestoreService.database.collection("users").document(user.uid).collection("groups").document(group.groupName).collection("Month").document(month).collection("workouts")
            
            ref.getDocuments { (snapshot, error) in
                if error != nil {
                    completion(workouts, error)
                    return
                } else {
                    guard let snapshot = snapshot else {
                        completion(workouts, error)
                        return
                    }
                    let documents = snapshot.documents
                    
                    for document in documents {
                        guard let workout = Workout(document: document.data()) else {
                            return
                        }
                        FirestoreWorkoutManager.fetchWorkoutLines(from: group, for: month, for: workout.workoutID) { (workoutLines, error) in
                            if error != nil {
                            } else {
                                workout.workoutLines = workoutLines
                            }
                        }
                        workouts.append(workout)
                    }
                    completion(workouts, nil)
                }
            }
        }
    }
    
    static func fetchWorkoutLines(from group: Group, for month: String, for workoutID: String, completion: @escaping ([WorkoutLine], Error?) -> () ){
        
        var workoutLines = [WorkoutLine]()
        
        if let user = Auth.auth().currentUser {
            let ref = FirestoreService.database.collection("users").document(user.uid).collection("groups").document(group.groupName).collection("Month").document(month).collection("workouts").document(workoutID).collection("workoutLines")
            
            ref.getDocuments { (snapshot, error) in
                if error != nil {
                    completion(workoutLines, error)
                } else {
                    guard let snapshot = snapshot else {
                        return
                    }
                    
                    let documents = snapshot.documents
                    
                    for document in documents {
                        guard let workoutLine = WorkoutLine(document: document.data()) else {
                            return
                        }
                        workoutLines.append(workoutLine)
                    }
                    completion(workoutLines, nil)
                }
            }
        }
    }
}
