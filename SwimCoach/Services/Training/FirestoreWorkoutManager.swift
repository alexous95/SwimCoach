//
//  FirestoreWorkoutManager.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 26/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirestoreWorkoutManager: NetworkWorkoutService {
    
    func fetchWorkout(from group: Group, for month: String, completion: @escaping ([Workout], Error?) -> ()) {
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
                        guard let workout = Workout(document: document.data()) else { return }
                        FirestoreWorkoutManager().fetchWorkoutLines(from: group, for: month, for: workout.workoutID) { (workoutLines, error) in
                            print(workout.workoutID)
                            if error != nil {
                                print("41: error fetching lines")
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
    
    func fetchWorkoutLines(from group: Group, for month: String, for workoutID: String, completion: @escaping ([WorkoutLine], Error?) -> () ){

        var workoutLines = [WorkoutLine]()
        
        if let user = Auth.auth().currentUser {
            let ref = FirestoreService.database.collection("users").document(user.uid).collection("groups").document(group.groupName).collection("Month").document(month).collection("workouts").document(workoutID).collection("workoutLines")
            
            ref.getDocuments { (snapshot, error) in
                if error != nil {
                    print("error")
                    completion(workoutLines, error)
                } else {
                    guard let snapshot = snapshot else { return }
                    
                    let documents = snapshot.documents
                    
                    for document in documents {
                        guard let workoutLine = WorkoutLine(document: document.data()) else { return }
                        workoutLines.append(workoutLine)
                        
                    }
                    completion(workoutLines, nil)
                }
            }
        }
    }
    
    func addWorkout(to group: Group, for month: String, title: String, date: String, workoutLines: [WorkoutLine]) {
        
        if let user = Auth.auth().currentUser {
            
            let ref = FirestoreService.database.collection("users").document(user.uid).collection("groups").document(group.groupName).collection("Month").document(month).collection("workouts")
            
            let id = ref.document().documentID
            let workout = Workout(title: title, date: date, workoutID: id)
            
            for workoutLine in workoutLines {
                addWorkoutLine(to: group, for: month, workoutID: id, workoutLine: workoutLine)
            }
            
            ref.document().setData(workout.dictionnary)
            
        }
    }
    
    private func addWorkoutLine(to group: Group, for month: String, workoutID: String, workoutLine: WorkoutLine) {
        if let user = Auth.auth().currentUser {
        
            let newWorkout = workoutLine
            
            let ref = FirestoreService.database.collection("users").document(user.uid).collection("groups").document(group.groupName).collection("Month").document(month).collection("workouts").document(workoutID).collection("workoutLines")
            
            let id = ref.document().documentID
            
            newWorkout.workoutLineID = id
            
            ref.document(id).setData(newWorkout.dictionnary)
            }
        }
}
