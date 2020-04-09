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
    
    var workoutLine: WorkoutLine = WorkoutLine()
    
    func updateWorkoutText(text: String) {
        workoutLine.text = text
    }
    
    func updateWorkoutTitle(text: String) {
        workoutLine.workoutLineTitle = text
    }
    
    func defaultFunction(distance: Double) {}
    
    func chooseFunc(from choice: Int) -> ( (Double) -> () ) {
        switch choice {
        case 1:
            return workoutLine.addZ1(distance:)
        case 2:
            return workoutLine.addZ2(distance:)
        case 3:
            return workoutLine.addZ3(distance:)
        case 4:
            return workoutLine.addZ4(distance:)
        case 5:
            return workoutLine.addZ5(distance:)
        case 6:
            return workoutLine.addZ6(distance:)
        case 7:
            return workoutLine.addZ7(distance:)
        case 10:
            return workoutLine.addAmpM(distance:)
        case 11:
            return workoutLine.addCoorM(distance:)
        case 12:
            return workoutLine.addEndM(distance:)
        case 20:
            return workoutLine.addCrawl(distance:)
        case 21:
            return workoutLine.addMedley(distance:)
        case 22:
            return workoutLine.addSpe(distance:)
        case 30:
            return workoutLine.addNageC(distance:)
        case 31:
            return workoutLine.addEduc(distance:)
        case 32:
            return workoutLine.addJbs(distance:)
        case 33:
            return workoutLine.addBras(distance:)
        default:
            return defaultFunction(distance:)
        }
    }
    
    
}
