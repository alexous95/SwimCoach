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
    
    @Published var dataAvaillable: Bool = false
    @Published var isLoading: Bool = false
    
    func numberOfItem() -> Int {
        guard let workouts = workouts else {
            print("10. guard workouts")
            return 0
        }
        return workouts.count
    }
    
    func fetchWorkout(from group: Group, for month: String) {
        isLoading = true
        FirestoreWorkoutManager.fetchWorkout(from: group, for: month) { (workouts, error) in
            if error != nil {
                print("30, error loading documents")
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
    
    
}
