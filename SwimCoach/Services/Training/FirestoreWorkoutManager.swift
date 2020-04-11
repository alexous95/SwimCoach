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
        
        DispatchQueue.main.async {
            guard let user = Auth.auth().currentUser else { return }
            
            let ref = FirestoreService.database.collection("users").document(user.uid).collection("groups").document(group.groupName).collection("Month").document(month).collection("workouts")
            
            ref.getDocuments { (snapshot, error) in
                if error != nil {
                    completion(workouts, error)
                    return
                }
                guard let snapshot = snapshot else {
                    completion(workouts, error)
                    return
                }
                let documents = snapshot.documents
                
                for document in documents {
                    guard let workout = Workout(document: document.data()) else { return }
                    FirestoreWorkoutManager().fetchWorkoutLines(from: group, for: month, for: workout.workoutID) { (workoutLines, error) in
                        if error != nil {
                            print(error?.localizedDescription as Any)
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
    
    func fetchWorkoutLines(from group: Group, for month: String, for workoutID: String, completion: @escaping ([WorkoutLine], Error?) -> () ){
        var workoutLines = [WorkoutLine]()
        
        DispatchQueue.main.async {
            guard let user = Auth.auth().currentUser else { return }
            let ref = FirestoreService.database.collection("users").document(user.uid).collection("groups").document(group.groupName).collection("Month").document(month).collection("workouts").document(workoutID).collection("workoutLines")
            
            ref.getDocuments { (snapshot, error) in
                if error != nil {
                    print("error")
                    completion(workoutLines, error)
                    return
                }
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

    
    func addWorkout(to group: Group, for month: String, workout: Workout) -> String {
    
        guard let user = Auth.auth().currentUser else { return "" }
        
        let ref = FirestoreService.database.collection("users").document(user.uid).collection("groups").document(group.groupName).collection("Month").document(month).collection("workouts")
        
        if workout.workoutID != "" {
            let ref2 = ref.document(workout.workoutID)
            
            ref2.updateData(workout.dictionnary) { (error) in
                if error != nil {
                    print(error?.localizedDescription as Any)
                }
            }
        } else {
            let id = ref.document().documentID
            let newWorkout = workout
            newWorkout.workoutID = id
            
            ref.document(id).setData(newWorkout.dictionnary)
            return id
            
        }
        return ""
        
    }
    
    func addWorkoutLine(to group: Group, for month: String, workoutID: String, workoutLine: WorkoutLine) {
        
        DispatchQueue.main.async {
            guard let user = Auth.auth().currentUser else { return }
            let newWorkout = workoutLine
            
            let ref = FirestoreService.database.collection("users").document(user.uid).collection("groups").document(group.groupName).collection("Month").document(month).collection("workouts").document(workoutID).collection("workoutLines")
            
            if workoutLine.workoutLineID != "" {
                let ref2 = ref.document(workoutLine.workoutLineID)
                ref2.updateData(workoutLine.dictionnary) { (error) in
                    if error != nil {
                        print(error?.localizedDescription as Any)
                    }
                }
            } else {
                let id = ref.document().documentID
                newWorkout.workoutLineID = id
                ref.document(id).setData(newWorkout.dictionnary)
            }
        }
        
    }
    
    func deleteWorkout(from group: Group, for month: String, workoutID: String) {
        
        DispatchQueue.main.async {
            guard let user = Auth.auth().currentUser else { return }
            let ref = FirestoreService.database.collection("users").document(user.uid).collection("groups").document(group.groupName).collection("Month").document(month).collection("workouts")
            
            let deleteRef = ref.document(workoutID)
            
            deleteRef.delete { (error) in
                if error !=  nil {
                    print("Error while deleting")
                    print(error.debugDescription)
                }
            }
        }
    }
    
    func deleteWorkoutLine(from group: Group, for month: String, workoutID: String, workoutLineID: String) {
        
        DispatchQueue.main.async {
            guard let user = Auth.auth().currentUser else { return }
            let ref = FirestoreService.database.collection("users").document(user.uid).collection("groups").document(group.groupName).collection("Month").document(month).collection("workouts").document(workoutID).collection("workoutLines")
            
            let deleteRef = ref.document(workoutLineID)
    
            deleteRef.delete { (error) in
                if error !=  nil {
                    print("Error while deleting")
                    print(error.debugDescription)
                } else {
                    print("Deletion succesful")
                }
            }
        }
    }
    
}
