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

   
    var database = DatabaseMock()
    var firestoreWorkoutMock: FirestoreWorkoutMock!
    var firestoreWorkoutErrorMock: FirestoreWorkoutMock!
    var viewModel: AddWorkoutLineViewModel!
    var viewModelError: AddWorkoutLineViewModel!
    let dateFormatter = DateFormatter()
    
    override func setUp() {
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "FR-fr")
        
        database.initDatabase()
        firestoreWorkoutMock = FirestoreWorkoutMock(databaseWorkout: database.databaseWorkout, databaseWorkoutLines: database.databaseWorkoutLines)
        firestoreWorkoutErrorMock = FirestoreWorkoutMock(databaseWorkout: database.databaseWorkout, databaseWorkoutLines: database.databaseWorkoutLines, error: database.error)
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
        
        let workoutLines = database.createWorkoutLines()
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
        
        viewModel.createWorkout(title: title, date: date, for: database.group, for: month)
        
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
        viewModel.createWorkout(title: title, date: date, for: database.group, for: month)
        
        let workoutLine = WorkoutLine(text: "test", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID", workoutLineTitle: "titleTest")
        viewModel.workoutLines.append(workoutLine)
        
        // When
        
        viewModel.addLineToWorkout(to: database.group, for: "April")
        
        // Then
        
        XCTAssertEqual(viewModel.workoutLines.count, viewModel.workout?.workoutLines.count)
    }
    
    
    func testGivenViewModel_WhenAddingLinesToNilWorkout_ThenLinesAreNotAdded() {
        // Given
        // When
        
        viewModel.addLineToWorkout(to: database.group, for: "April")
        
        // Then
        
        XCTAssertNil(viewModel.workout)
    }
    
    func testGivenViewModel_WhenPrintingDate_ThenDateIsConform() {
        // Given
        
        let now = Date()
        let dateString = dateFormatter.string(from: now)
        
        // When
        
        let date = viewModel.printDate()
        
        // Then
        
        XCTAssertEqual(dateString, date)
        
    }
    
    func testGivenViewModel_WhenPrintingDateFromSelectedDate_ThenDateIsConform() {
        // Given
        
        guard let selectedDate = dateFormatter.date(from: "08/04/2020") else {
            XCTFail("Expected a Date at this point")
            return
        }
        
        let selectedString = dateFormatter.string(from: selectedDate)
        
        // When
        
        let date = viewModel.printDate(from: selectedDate)
        
        // Then
        
        XCTAssertEqual(selectedString, date)
    }
}
