//
//  DetailWorkoutViewModel.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 27/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation

final class DetailWorkoutViewModel {
    
    var workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
    }
    
    func getPercentageZ1() -> String {
        let distance = (workout.getDistanceZ1()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    func getPercentageZ2() -> String {
        let distance = (workout.getDistanceZ2()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    func getPercentageZ3() -> String {
        let distance = (workout.getDistanceZ3()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    func getPercentageZ4() -> String {
        let distance = (workout.getDistanceZ4()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    func getPercentageZ5() -> String {
        let distance = (workout.getDistanceZ5()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    func getPercentageZ6() -> String {
        let distance = (workout.getDistanceZ6()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    func getPercentageZ7() -> String {
        let distance = (workout.getDistanceZ7()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    func convertToString(distance: Double) -> String {
        return String(format: "%.1f", distance)
    }
}
