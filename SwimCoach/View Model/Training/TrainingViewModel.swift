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
    
    var workouts: [Workout]?
    var error: String = ""
    
    private let network: NetworkWorkoutService
    
    @Published var dataAvaillable: Bool = false
    @Published var isLoading: Bool = false
    
    init(network: NetworkWorkoutService = FirestoreWorkoutManager()) {
        self.network = network
    }
    
    func numberOfItem() -> Int {
        guard let workouts = workouts else {
            return 0
        }
        return workouts.count
    }
    
    func fetchWorkout(from group: Group, for month: String) {
        isLoading = true
        network.fetchWorkout(from: group, for: month) { (workouts, error) in
            if error != nil {
                self.error = error.debugDescription
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
    
    func deleteWorkout(from group: Group, for month: String, workout: Workout) {
        network.deleteWorkout(from: group, for: month, workoutID: workout.workoutID)
        fetchWorkout(from: group, for: month)
    }
    
    
}
