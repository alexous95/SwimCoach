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
    
    @Published var workoutText: String = ""
    @Published var workoutLineTitle: String = ""
    
    var temporaryWorkoutLine = WorkoutLine()
    var workoutLine = WorkoutLine()
    
    func updateWorkoutText(text: String) {
        temporaryWorkoutLine.text = text
    }
    
    func updateWorkoutTitle(text: String) {
        temporaryWorkoutLine.workoutLineTitle = text
    }
    
    func save() {
        temporaryWorkoutLine.workoutLineID = workoutLine.workoutLineID
        workoutLine = temporaryWorkoutLine
    }
    
    func prepareForDisplay() {
        temporaryWorkoutLine = workoutLine
    }
    
    func defaultFunction(distance: Double) {}
    
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
