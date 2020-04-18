//
//  FirestoreWorkoutManager.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 26/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
import FirebaseAuth

/// A class that manage our workouts
///
/// This class is used to make the calls to the database
class FirestoreWorkoutManager: NetworkWorkoutService {
    
    /// Fetch the documents from the group's collection
    /// - Parameter group: The group we want to fetch the document from
    /// - Parameter month: The month we want to fetch our workout from
    /// - Parameter completion: An escaping closure of type ([Workout], Error?) to pass data to another class
    /// We use this class to populate our model in the viewModel
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
    
    /// Fetch the documents from the group's collection
    /// - Parameter group: The group we want to fetch the document from
    /// - Parameter month: The month we want to fetch our workout from
    /// - Parameter workoutID: The workout id we want to fetch data from
    /// - Parameter completion: An escaping closure of type ([WorkoutLine], Error?) to pass data to another class
    /// We use this class to populate our model in the viewModel
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

    /// Add a document to the workout's collection
    /// - Parameter group: The group we want to add workout to
    /// - Parameter month: The month we want to add workout to
    /// - Parameter workout: The object that will be added to the database
    /// The workout model has a property dictionnary of type [String : Any] used to add data to firestore
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
    
    /// Add a document to the workoutLines's collection
    /// - Parameter group: The group we want to add workout to
    /// - Parameter month: The month we want to add workout to
    /// - Parameter workoutID: The workout we want to add a line
    /// The workoutLine model has a property dictionnary of type [String : Any] used to add data to firestore
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
    
    /// Delete a document from the Workout's collection
    /// - Parameter group: The group we want to delete a workout from
    /// - Parameter month: The month we want to delete a workout from
    /// - Parameter workoutID: The workout we want to delete
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
    
    /// Delete a document from the WorkoutLines's collection
    /// - Parameter group: The group we want to delete a workout from
    /// - Parameter month: The month we want to delete a workout from
    /// - Parameter workoutID: The workout we want to delete a line from
    /// - Parameter workoutLineID: The workoutLine we want to delete
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
