//
//  TrainingViewModel.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 26/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
import Combine

final class TrainingViewModel {
    
    // MARK: - Variables
    
    /// An array that hold our fetched data
    var workouts: [Workout]?
    
    /// Property that hold an error
    var error: String = ""
    
    /// Dependency injection
    ///
    /// We mock this property to test our code
    private let network: NetworkWorkoutService
    
    /// Publisher that is used as a signal of new available data
    @Published var dataAvaillable: Bool = false
    
    /// Publisher for the activity wheel
    @Published var isLoading: Bool = false
    
    // MARK: - Init
    
    init(network: NetworkWorkoutService = FirestoreWorkoutManager()) {
        self.network = network
    }
    
    /// Returns the number of workouts
    ///
    /// - Returns: An int representing our array count
    func numberOfItem() -> Int {
        guard let workouts = workouts else {
            return 0
        }
        return workouts.count
    }
    
    // MARK: - Database Functions
    
    /// Fetch data from FireStore and updates the publisher to signal there is data availlable
    ///
    /// In this function we change the value of our publisher to update the UI in the view controller
    func fetchWorkout(from group: Group, for month: String) {
        isLoading = true
        network.fetchWorkout(from: group, for: month) { (workouts, error) in
            if error != nil {
                self.error = "error while loading workouts"
                self.isLoading = false
                return
            } else {
                self.workouts = workouts
                self.dataAvaillable = true
                self.isLoading = false
                self.dataAvaillable = false
            }
        }
    }
    
    /// Deletes a group from the database
    /// - Parameter group: The group we want to delete from
    /// - Parameter month: The month we want to delete from
    /// - Parameter workout: The workout we want to delete
    ///
    /// We use the network property to delete the group from the database and update our data
    func deleteWorkout(from group: Group, for month: String, workout: Workout) {
        network.deleteWorkout(from: group, for: month, workoutID: workout.workoutID)
        fetchWorkout(from: group, for: month)
    }
    
    
}
