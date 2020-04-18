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
    
     /// Publisher for the activity wheel
    @Published var isLoading: Bool = false
    
    /// Publisher that is used as a signal of new available data
    @Published var dataAvaillable: Bool = false
    
    /// Property that hold the workout we are going to display
    var workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
    }
    
    // MARK: - Zone Functions
    
    /// Returns the percentage of zone 1 in the workout
    ///
    /// Returns the a string with the result of the percentage operation
    func getPercentageZ1() -> String {
        let distance = (workout.getDistanceZ1()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    /// Returns the percentage of zone 2 in the workout
    ///
    /// Returns the a string with the result of the percentage operation
    func getPercentageZ2() -> String {
        let distance = (workout.getDistanceZ2()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    /// Returns the percentage of zone 3 in the workout
    ///
    /// Returns the a string with the result of the percentage operation
    func getPercentageZ3() -> String {
        let distance = (workout.getDistanceZ3()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    /// Returns the percentage of zone 4 in the workout
    ///
    /// Returns the a string with the result of the percentage operation
    func getPercentageZ4() -> String {
        let distance = (workout.getDistanceZ4()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    /// Returns the percentage of zone 5 in the workout
    ///
    /// Returns the a string with the result of the percentage operation
    func getPercentageZ5() -> String {
        let distance = (workout.getDistanceZ5()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    /// Returns the percentage of zone 6 in the workout
    ///
    /// Returns the a string with the result of the percentage operation
    func getPercentageZ6() -> String {
        let distance = (workout.getDistanceZ6()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    /// Returns the percentage of zone 7 in the workout
    ///
    /// Returns the a string with the result of the percentage operation
    func getPercentageZ7() -> String {
        let distance = (workout.getDistanceZ7()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    // MARK: - Motricity Functions
    
    /// Returns the percentage of Amplitude motricity in the workout
    ///
    /// Returns the a string with the result of the percentage operation
    func getPercentageAmpM() -> String {
        let distance = (workout.getDistanceAmpM()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    /// Returns the percentage of Coordination motricity in the workout
    ///
    /// Returns the a string with the result of the percentage operation
    func getPercentageCoorM() -> String {
        let distance = (workout.getDistanceCoorM()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    /// Returns the percentage of Endurance motricity in the workout
    ///
    /// Returns the a string with the result of the percentage operation
    func getPercentageEndM() -> String {
        let distance = (workout.getDistanceEndM()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    // MARK: - Strokes Functions
    
    /// Returns the percentage of Crawl in the workout
    ///
    /// Returns the a string with the result of the percentage operation
    func getPercentageCrawl() -> String {
        let distance = (workout.getDistanceCrawl()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    /// Returns the percentage of Medley in the workout
    ///
    /// Returns the a string with the result of the percentage operation
    func getPercentageMedley() -> String {
        let distance = (workout.getDistanceMedley()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    /// Returns the percentage of Specialty in the workout
    ///
    /// Returns the a string with the result of the percentage operation
    func getPercentageSpe() -> String {
        let distance = (workout.getDistanceSpe()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    // MARK: - Exercices Functions
    
    /// Returns the percentage of Educative in the workout
    ///
    /// Returns the a string with the result of the percentage operation
    func getPercentageEduc() -> String {
        let distance = (workout.getDistanceEduc()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    /// Returns the percentage of NageC in the workout
    ///
    /// Returns the a string with the result of the percentage operation
    func getPercentageNageC() -> String {
        let distance = (workout.getDistanceNageC()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    /// Returns the percentage of Jbs in the workout
    ///
    /// Returns the a string with the result of the percentage operation
    func getPercentageJbs() -> String {
        let distance = (workout.getDistanceJbs()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    /// Returns the percentage of Arm in the workout
    ///
    /// Returns the a string with the result of the percentage operation
    func getPercentageBras() -> String {
        let distance = (workout.getDistanceBras()/workout.getDistance()) * 100
        return convertToString(distance: distance)
    }
    
    /// Returns the percentage the text in the workout
    ///
    /// Returns the a string with the result of the percentage operation
    func getWorkoutText() -> String {
        let fullWorkout = workout.description().joined(separator: "\n \n")
        let correctWorkout = fullWorkout.replacingOccurrences(of: "\\n", with: "\n")
        
        return correctWorkout
    }
    
    /// Returns a string from a double
    func convertToString(distance: Double) -> String {
        return String(format: "%.1f", distance)
    }
}
