//
//  AddWorkoutLineDetailViewModelTest.swift
//  SwimCoachTests
//
//  Created by Alexandre Goncalves on 17/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import XCTest
@testable import SwimCoach

class AddWorkoutLineDetailViewModelTest: XCTestCase {
    
    enum WorkoutLineError : Error {
        case empty
    }
    
    var group: Group!
    var error: WorkoutLineError!
    var databaseWorkout: [String : [String : [Workout]]]!
    var databaseWorkoutLines: [String : [WorkoutLine]]!
    var firestoreWorkoutMock: FirestoreWorkoutMock!
    var firestoreWorkoutErrorMock: FirestoreWorkoutMock!
    var viewModel: AddWorkoutLineDetailViewModel!
    var viewModelError: AddWorkoutLineDetailViewModel!
    let dateFormatter = DateFormatter()
    
    func createWorkoutLines() -> [WorkoutLine] {
        let workoutLine = WorkoutLine(text: "test", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID", workoutLineTitle: "titleTest")
        
        let workoutLine2 = WorkoutLine(text: "test2", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID2", workoutLineTitle: "titleTest2")
        
        let workoutLines = [workoutLine, workoutLine2]
        
        return workoutLines
    }
    
    func createWorkouts() -> [Workout] {
        
        let workoutLines = createWorkoutLines()
        var databaseWorkoutLines = [String : [WorkoutLine]]()
        
        var workouts = [Workout]()
        
        for index in 0...2 {
            let workout = Workout(title: "testTitle" + "\(index)", date: "testDate" + "\(index)", workoutID: "testID" + "\(index)", workoutLines: workoutLines)
            workouts.append(workout)
            
            databaseWorkoutLines[workout.workoutID] = workoutLines
        }
        
        return workouts
    }
    
    
    func createWorkoutDatabase() -> [String : [String : [Workout]]] {
        let workout = createWorkouts()
        
        let databaseWorkout = ["Arctique" : ["April" : workout]]
        
        return databaseWorkout
    }
    
    func createWorkoutLinesDatabase() -> [String: [WorkoutLine]] {
        
        let workoutLines = createWorkoutLines()
        var databaseWorkoutLines = [String : [WorkoutLine]]()
        
        for index in 0...2 {
            databaseWorkoutLines["testID" + "\(index)"] = workoutLines
        }
        
        return databaseWorkoutLines
    }
    
    func createGroup() -> Group {
        return Group(groupName: "Arctique")
    }
    
    override func setUp() {
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "FR-fr")
        
        group = Group(groupName: "Arctique")
        databaseWorkout = createWorkoutDatabase()
        databaseWorkoutLines = createWorkoutLinesDatabase()
        error = .empty
        firestoreWorkoutMock = FirestoreWorkoutMock(databaseWorkout: databaseWorkout, databaseWorkoutLines: databaseWorkoutLines)
        firestoreWorkoutErrorMock = FirestoreWorkoutMock(databaseWorkout: databaseWorkout, databaseWorkoutLines: databaseWorkoutLines, error: error)
        viewModel = AddWorkoutLineDetailViewModel(network: firestoreWorkoutMock)
        viewModelError = AddWorkoutLineDetailViewModel(network: firestoreWorkoutErrorMock)
    }

    
    func testGivenNil_WhenCreatingViewModel_ThenViewModelIsNotNil() {
        // Given
        // When
        
        let viewModel = AddWorkoutLineDetailViewModel(network: firestoreWorkoutMock)
        
        // Then
        
        XCTAssertNotNil(viewModel)
    }
    
    
    func testGivenViewModel_WhenUpdatingText_ThenTextIsCorrectlyUpdated() {
        // Given
        
        let text = "testUpdate"
        
        // When
        
        viewModel.updateWorkoutText(text: text)
        
        // Then
        
        XCTAssertEqual(viewModel.temporaryWorkoutLine.text, text)
    }
    
    func testGivenViewModel_WhenUpdatingTitle_ThenTitleIsCorrectlyUpdated() {
        // Given
        
        let text = "testUpdate"
        
        // When
        
        viewModel.updateWorkoutTitle(text: text)
        
        // Then
        
        XCTAssertEqual(viewModel.temporaryWorkoutLine.workoutLineTitle, text)
    }
}
