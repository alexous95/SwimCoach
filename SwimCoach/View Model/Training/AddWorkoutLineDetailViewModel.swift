//
//  AddWorkoutLineDetailViewModel.swift
//  SwimCoach
//
//  Created by Alexandre Goncalves on 02/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import Foundation
import Combine

final class AddWorkoutLineDetailViewModel {
    
    // MARK: - Variables
    
    /// Publisher for the workoutTitle
    @Published var workoutText: String = ""
    
    /// Publisher for the workoutLineTitle
    @Published var workoutLineTitle: String = ""
    
    /// A temporary Line that hold our data
    var temporaryWorkoutLine = WorkoutLine()
    
    /// The workoutLine that is going to be added
    var workoutLine = WorkoutLine()
    
    /// Dependency injection
    ///
    /// We mock this property to test our code
    private let network: NetworkWorkoutService
    
    // MARK: - Init
    
    init(network: NetworkWorkoutService = FirestoreWorkoutManager()) {
        self.network = network
    }
    
    // MARK: - Update function
    
    /// Update the workoutLine text
    /// - Parameter text: The text used to update the workoutline text
    func updateWorkoutText(text: String) {
        temporaryWorkoutLine.text = text
    }
    
    /// Update the workoutLine title
    /// - Parameter text: The text used to update the workoutline title
    func updateWorkoutTitle(text: String) {
        temporaryWorkoutLine.workoutLineTitle = text
    }
    
    /// Saves the workout line
    ///
    /// - Parameter group: The group we want to save our workout to
    /// - Parameter month: The month we want to save our workout to
    /// - Parameter workout: The workout we want to save our line to
    ///
    /// We use the network property to save our line
    func save(for group: Group, for month: String, workout: Workout) {
        temporaryWorkoutLine.workoutLineID = workoutLine.workoutLineID
        workoutLine = temporaryWorkoutLine
        network.addWorkoutLine(to: group, for: month, workoutID: workout.workoutID, workoutLine: workoutLine)
    }
    
    /// Assigne the workoutLine to a temporary one to not delete of info if the user cancel is action
    func prepareForDisplay() {
        temporaryWorkoutLine = workoutLine
    }
    
    /// Default function for our switch case
    func defaultFunction(distance: Double) {}
    
    /// Returns a function from a choice
    func chooseFunc(from choice: Int) -> ( (Double) -> () ) {
        switch choice {
        case 1:
            return temporaryWorkoutLine.addZ1(distance:)
        case 2:
            return temporaryWorkoutLine.addZ2(distance:)
        case 3:
            return temporaryWorkoutLine.addZ3(distance:)
        case 4:
            return temporaryWorkoutLine.addZ4(distance:)
        case 5:
            return temporaryWorkoutLine.addZ5(distance:)
        case 6:
            return temporaryWorkoutLine.addZ6(distance:)
        case 7:
            return temporaryWorkoutLine.addZ7(distance:)
        case 10:
            return temporaryWorkoutLine.addAmpM(distance:)
        case 11:
            return temporaryWorkoutLine.addCoorM(distance:)
        case 12:
            return temporaryWorkoutLine.addEndM(distance:)
        case 20:
            return temporaryWorkoutLine.addCrawl(distance:)
        case 21:
            return temporaryWorkoutLine.addMedley(distance:)
        case 22:
            return temporaryWorkoutLine.addSpe(distance:)
        case 30:
            return temporaryWorkoutLine.addNageC(distance:)
        case 31:
            return temporaryWorkoutLine.addEduc(distance:)
        case 32:
            return temporaryWorkoutLine.addJbs(distance:)
        case 33:
            return temporaryWorkoutLine.addBras(distance:)
        default:
            return defaultFunction(distance:)
        }
    }
    
    
}
