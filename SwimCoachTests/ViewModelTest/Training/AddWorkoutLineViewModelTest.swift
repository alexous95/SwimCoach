//
//  AddWorkoutLineViewModelTest.swift
//  SwimCoachTests
//
//  Created by Alexandre Goncalves on 17/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import XCTest
@testable import SwimCoach

class AddWorkoutLineViewModelTest: XCTestCase {

    enum WorkoutLineError : Error {
        case empty
    }
    
    var group: Group!
    var error: WorkoutLineError!
    var databaseWorkout: [String : [String : [Workout]]]!
    var databaseWorkoutLines: [String : [WorkoutLine]]!
    var firestoreWorkoutMock: FirestoreWorkoutMock!
    var firestoreWorkoutErrorMock: FirestoreWorkoutMock!
    var viewModel: AddWorkoutLineViewModel!
    var viewModelError: AddWorkoutLineViewModel!
    
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
        group = Group(groupName: "Arctique")
        databaseWorkout = createWorkoutDatabase()
        databaseWorkoutLines = createWorkoutLinesDatabase()
        error = .empty
        firestoreWorkoutMock = FirestoreWorkoutMock(databaseWorkout: databaseWorkout, databaseWorkoutLines: databaseWorkoutLines)
        firestoreWorkoutErrorMock = FirestoreWorkoutMock(databaseWorkout: databaseWorkout, databaseWorkoutLines: databaseWorkoutLines, error: error)
        viewModel = AddWorkoutLineViewModel(network: firestoreWorkoutMock)
        viewModelError = AddWorkoutLineViewModel(network: firestoreWorkoutErrorMock)
    }

    
    func testGivenNil_WhenCreatingViewModel_ThenResultIsNotNil() {
        // Given
        // When
        
        let viewModel = AddWorkoutLineViewModel(network: firestoreWorkoutMock)
        
        // Then
        
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel.title, "")
        XCTAssertEqual(viewModel.workoutLines.count, 0)
    }
    
    
    func testGivenViewModel_WhenGettingNumberOfLines_ThenResultIsZeroIfWorkoutLineIsEmpty() {
        // Given
        
        // When
        
        let lines = viewModel.getNumberOfLines()
        
        // Then
        
        XCTAssertEqual(lines, 0)
    }
    
    
    func testGivenViewModel_WhenGettingNumberOfLines_ThenResultIsArrayCount() {
        // Given
        
        let workoutLines = createWorkoutLines()
        viewModel.workoutLines = workoutLines
        
        // When
        
        let lines = viewModel.getNumberOfLines()
        
        // Then
        
        XCTAssertEqual(lines, 2)
        
    }
    
    
    func testGivenViewModel_WhenCreatingWorkout_ThenWorkoutIsCreatedCorrectly() {
        // Given
        
        let title = "test42"
        let date = "08/04/2020"
        let month = "April"
        
        // When
        
        viewModel.createWorkout(title: title, date: date, for: group, for: month)
        
        // Then
        
        XCTAssertNotNil(viewModel.workout)
        XCTAssertEqual(viewModel.workout?.title, title)
        XCTAssertEqual(viewModel.workout?.date, date)
        XCTAssertEqual(viewModel.workout?.workoutID, "test")
    }
    
    
    func testGivenViewModel_WhenAddingWorkoutLines_ThenWorkoutLineIsAddedCorrectly() {
        // Given
        
        let lines = viewModel.workoutLines.count
        let workoutLine = WorkoutLine(text: "test", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID42", workoutLineTitle: "titleTest")
        
        // When
        
        viewModel.addWorkoutLine(workoutLine)
        
        // Then
        
        XCTAssertEqual(viewModel.workoutLines.count, lines + 1)
        XCTAssertEqual(viewModel.workoutLines[0].workoutLineID, "testID42")
    }
    
    
    func testGivenViewModel_WhenAddingWorkoutLines_ThenWorkoutIsAddedIfIdAreDifferent() {
        // Given
        
        let lines = viewModel.workoutLines.count
        let workoutLine = WorkoutLine(text: "test", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID42", workoutLineTitle: "titleTest")
        let workoutLine2 = WorkoutLine(text: "test42", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID42", workoutLineTitle: "titleTest42")
        
        // When
        
        viewModel.addWorkoutLine(workoutLine)
        viewModel.addWorkoutLine(workoutLine2)
        
        // Then
        
        XCTAssertEqual(viewModel.workoutLines.count, lines + 1)
        XCTAssertEqual(viewModel.workoutLines[0].workoutLineID, "testID42")
        XCTAssertEqual(viewModel.workoutLines[0].workoutLineTitle, "titleTest42")
        XCTAssertEqual(viewModel.workoutLines[0].text, "test42")
    }
    
    
    func testGivenViewModel_WhenAddingWorkoutLines_ThenWorkoutLineIsAdded() {
        // Given
        
        let lines = viewModel.workoutLines.count
        let workoutLine = WorkoutLine(text: "test", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID42", workoutLineTitle: "titleTest")
        let workoutLine2 = WorkoutLine(text: "test423", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID423", workoutLineTitle: "titleTest423")
        
        // When
        
        viewModel.addWorkoutLine(workoutLine)
        viewModel.addWorkoutLine(workoutLine2)
        
        // Then
        
        XCTAssertEqual(viewModel.workoutLines.count, lines + 2)
        XCTAssertEqual(viewModel.workoutLines[0].workoutLineID, "testID42")
        XCTAssertEqual(viewModel.workoutLines[0].workoutLineTitle, "titleTest")
        XCTAssertEqual(viewModel.workoutLines[0].text, "test")
        XCTAssertEqual(viewModel.workoutLines[1].workoutLineID, "testID423")
        XCTAssertEqual(viewModel.workoutLines[1].workoutLineTitle, "titleTest423")
        XCTAssertEqual(viewModel.workoutLines[1].text, "test423")
    }
    
    
    func testGivenViewModel_WhenAddingLinesToWorkout_ThenLinesAreAddedToWorkout() {
        // Given
        
        let title = "test42"
        let date = "08/04/2020"
        let month = "April"
        viewModel.createWorkout(title: title, date: date, for: group, for: month)
        
        // When
        
        
    }
}
