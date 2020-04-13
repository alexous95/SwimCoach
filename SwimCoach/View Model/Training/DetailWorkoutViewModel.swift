//
//  DetailWorkoutViewModel.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 27/03/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
import Combine

final class DetailWorkoutViewModel {
    
    @Published var isLoading: Bool = false
    @Published var dataAvaillable: Bool = false
    
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
    
    func getPercentageAmpM() -> String {
        let distance = (workout.getDistanceAmpM()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    func getPercentageCoorM() -> String {
        let distance = (workout.getDistanceCoorM()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    func getPercentageEndM() -> String {
        let distance = (workout.getDistanceEndM()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    func getPercentageEduc() -> String {
        let distance = (workout.getDistanceEduc()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    func getPercentageCrawl() -> String {
        let distance = (workout.getDistanceCrawl()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    func getPercentageMedley() -> String {
        let distance = (workout.getDistanceMedley()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    func getPercentageSpe() -> String {
        let distance = (workout.getDistanceSpe()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    func getPercentageNageC() -> String {
        let distance = (workout.getDistanceNageC()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    func getPercentageJbs() -> String {
        let distance = (workout.getDistanceJbs()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    func getPercentageBras() -> String {
        let distance = (workout.getDistanceBras()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    func getWorkoutText() -> String {
        let fullWorkout = workout.description().joined(separator: "\n \n")
        let correctWorkout = fullWorkout.replacingOccurrences(of: "\\n", with: "\n")
        
        return correctWorkout
    }
    
    func convertToString(distance: Double) -> String {
        return String(format: "%.1f", distance)
    }
}
