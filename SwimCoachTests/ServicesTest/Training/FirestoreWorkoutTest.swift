//
//  FirestoreWorkoutTest.swift
//  SwimCoachTests
//
//  Created by Alexandre Goncalves on 16/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import XCTest
@testable import SwimCoach

class FirestoreWorkoutTest: XCTestCase {

    enum WorkoutError: Error {
        case empty
    }
    
    var databaseWorkout: [String : [String: [Workout]]]!
    var databaseWorkoutLines: [String: [WorkoutLine]]!
    var error: WorkoutError!
    var group: Group!
    var workoutManager: FirestoreWorkoutMock!
    var workoutManagerError: FirestoreWorkoutMock!
    
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
    
    func createError() -> WorkoutError {
        return .empty
    }
    
    override func setUp() {

        databaseWorkout = createWorkoutDatabase()
        databaseWorkoutLines = createWorkoutLinesDatabase()
        group = createGroup()
        error = createError()
        workoutManager = FirestoreWorkoutMock(databaseWorkout: databaseWorkout, databaseWorkoutLines: databaseWorkoutLines)
        workoutManagerError = FirestoreWorkoutMock(databaseWorkout: databaseWorkout, databaseWorkoutLines: databaseWorkoutLines, error: error)
        
    }
    
    
    
    func testGivenWorkoutService_WhenFetchingWorkouts_ThenArrayEqualsDatabaseWorkouts() {
        // Given
        
        let expectation = XCTestExpectation(description: "Fetching Workout")
        let workoutCount = databaseWorkout[group.groupName]?["April"]?.count
        
        // When
        
        workoutManager.fetchWorkout(from: group, for: "April") { (workouts, error) in
            // Then
            
            XCTAssertNil(error)
            XCTAssertEqual(workouts.count, workoutCount)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGivenWorkoutService_WhenFetchingWorkoutsWithError_ThenArrayIsEmpty() {
        // Given
        
        let expectation = XCTestExpectation(description: "Loading Workout")
        
        // When
        
        workoutManagerError.fetchWorkout(from: group, for: "April") { (workouts, error) in
            // Then
            
            XCTAssertNotNil(error)
            XCTAssertEqual(workouts.count, 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGivenWorkoutService_WhenFetchingWorkoutFromWrongMonth_ThenArrayIsEmpty() {
        // Given
        
        let expectation = XCTestExpectation(description: "Loading Workout")
        
        // When
        
        workoutManager.fetchWorkout(from: group, for: "Fail") { (workouts, error) in
            
            XCTAssertNil(error)
            XCTAssertEqual(workouts.count, 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGivenWorkoutService_WhenFetchingWorkoutLines_ThenArrayIsEqualDatabase() {
        // Given
        
        let expectation = XCTestExpectation(description: "Loading workout lines")
        
        // When
        
        workoutManager.fetchWorkoutLines(from: group, for: "April", for: "testID0") { (workoutLines, error) in
            // Then
            
            XCTAssertNil(error)
            XCTAssertEqual(workoutLines.count, self.databaseWorkoutLines["testID0"]?.count)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGivenWorkoutService_WhenFetchingWorkoutLinesWithError_ThenArrayIsEmpty() {
        // Given
        
        let expectation = XCTestExpectation(description: "Loading workoutLines")
        
        // When
        
        workoutManagerError.fetchWorkoutLines(from: group, for: "April", for: "testID0") { (workoutLines, error) in
            
            XCTAssertNotNil(error)
            XCTAssertEqual(workoutLines.count, 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGivenWorkoutService_WhenDeletingWorkout_ThenTheCorrectWorkoutIsDeleted() {
        // Given
        
        var countWorkout = 0
        var isPresent = false
        
        workoutManager.fetchWorkout(from: group, for: "April") { (workouts, error) in
            countWorkout = workouts.count
        }
        
        // When
        
        workoutManager.deleteWorkout(from: group, for: "April", workoutID: "testID0")
        
        // Then
        
        workoutManager.fetchWorkoutLines(from: group, for: "April", for: "testID0") { (workoutLines, error) in
            
            XCTAssertEqual(workoutLines.count, 0)
            XCTAssertNil(error)
        }
        
        workoutManager.fetchWorkout(from: group, for: "April") { (workouts, error) in
            
            XCTAssertEqual(workouts.count, countWorkout - 1)
            for workout in workouts {
                if workout.workoutID == "testID0" {
                    isPresent = true
                }
            }
            XCTAssertFalse(isPresent)
        }
    }
    
    
    func testGivenWorkoutService_WhenDeletingWorkoutLines_ThenTheCorrectWorkoutLinesIsDeleted() {
        // Given
        
        var countWorkoutLines = 0
        var isPresent = false
        
        workoutManager.fetchWorkoutLines(from: group, for: "April", for: "testID0") { (workoutLines, error) in
            countWorkoutLines = workoutLines.count
        }
        
        // When
        
        workoutManager.deleteWorkoutLine(from: group, for: "April", workoutID: "testID0", workoutLineID: "testID")
        
        // Then
        
        workoutManager.fetchWorkoutLines(from: group, for: "April", for: "testID0") { (workoutLines, error) in
            
            XCTAssertEqual(workoutLines.count, countWorkoutLines - 1)
            
            for workoutLine in workoutLines {
                if workoutLine.workoutLineID == "testID" {
                    isPresent = true
                }
            }
            XCTAssertFalse(isPresent)
        }
    }
    
    
    func testGivenWorkoutService_WhenAddingWorkoutWithID_ThenWorkoutIsAddedCorrectly() {
        // Given
        
        var countWorkout = 0
        
        let workout = Workout(title: "testTitle", date: "testDate", workoutID: "testID", workoutLines: [])
        
        workoutManager.fetchWorkout(from: group, for: "April") { (workouts, error) in
            countWorkout = workouts.count
        }
        
        // When
        
        let workoutID = workoutManager.addWorkout(to: group, for: "April", workout: workout)
        
        // Then
        
        workoutManager.fetchWorkout(from: group, for: "April") { (workouts, error) in
            
            XCTAssertEqual(workouts.count, countWorkout + 1)
            XCTAssertEqual(workoutID, "testID")
        }
    }
    
    
    func testGivenWorkoutService_WhenAddingWorkoutWithoutID_ThenWorkoutIsAddedWithDefautID() {
        // Given
        
        var countWorkout = 0
        let workoutWithoutID = Workout(title: "testTitle", date: "testDate", workoutID: "", workoutLines: [])
        
        workoutManager.fetchWorkout(from: group, for: "April") { (workouts, error) in
            countWorkout = workouts.count
        }
        
        // When
        
        let workoutID = workoutManager.addWorkout(to: group, for: "April", workout: workoutWithoutID)
        
        // Then
        
        workoutManager.fetchWorkout(from: group, for: "April") { (workouts, error) in
            
            XCTAssertEqual(workouts.count, countWorkout + 1)
            XCTAssertEqual(workoutID, "test")
        }
    }
    
    
    func testGivenWorkoutService_WhenUpdatingWorkout_ThenWorkoutIsUpdated() {
        // Given
        
        var countWorkout = 0
        let workout = Workout(title: "testTitle", date: "testDate", workoutID: "testID0", workoutLines: [])
        workoutManager.fetchWorkout(from: group, for: "April") { (workouts, error) in
            countWorkout = workouts.count
        }
        
        // When
        
        let workoutID = workoutManager.addWorkout(to: group, for: "April", workout: workout)
        
        // Then
        
        workoutManager.fetchWorkout(from: group, for: "April") { (workouts, error) in
            
            XCTAssertEqual(workouts.count, countWorkout)
            XCTAssertEqual(workoutID, "testID0")
            XCTAssertEqual(workouts[0].workoutLines.count, 0)
        }
    }
    
    
    func testGivenWorkoutService_WhenAddingWorkouLines_ThenWorkoutLineIsAdded() {
        // Given
        
        var countWorkoutLines = 0
        let workoutLine = WorkoutLine(text: "test", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testLineID", workoutLineTitle: "titleTest")
        
        workoutManager.fetchWorkoutLines(from: group, for: "April", for: "testID0") { (workoutLines, error) in
            countWorkoutLines = workoutLines.count
        }
        
        // When
        
        workoutManager.addWorkoutLine(to: group, for: "April", workoutID: "testID0", workoutLine: workoutLine)
        
        // Then
        
        workoutManager.fetchWorkoutLines(from: group, for: "April", for: "testID0") { (workoutLines, error) in
            
            XCTAssertEqual(workoutLines.count, countWorkoutLines + 1)
        }
    }
    
    
    func testGivenWorkoutService_WhenAddingWorkoutLineWithoutID_ThenWorkoutLineIsAddedWithDefaultID() {
        // Given
        
        var countWorkoutLines = 0
        let workoutLine = WorkoutLine(text: "test", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "", workoutLineTitle: "titleTest")
        
        workoutManager.fetchWorkoutLines(from: group, for: "April", for: "testID0") { (workoutLines, error) in
            countWorkoutLines = workoutLines.count
        }
        
        // When
        
        workoutManager.addWorkoutLine(to: group, for: "April", workoutID: "testID0", workoutLine: workoutLine)
        
        // Then
        
        workoutManager.fetchWorkoutLines(from: group, for: "April", for: "testID0") { (workoutLines, error) in
            
            XCTAssertEqual(workoutLines.count, countWorkoutLines + 1)
            XCTAssertEqual(workoutLines[2].workoutLineID, "testLine")
        }
        
    }
    
    
    func testGivenWorkoutService_WhenUpdatingWorkoutLine_ThenWorkoutLineIsUpdated() {
        // Given
        
        var countWorkoutLines = 0
        let workoutLine = WorkoutLine(text: "test + test", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID", workoutLineTitle: "titleTest")
        
        workoutManager.fetchWorkoutLines(from: group, for: "April", for: "testID0") { (workoutLines, error) in
            countWorkoutLines = workoutLines.count
        }
        
        // When
        
        workoutManager.addWorkoutLine(to: group, for: "April", workoutID: "testID0", workoutLine: workoutLine)
        
        // Then
        
        workoutManager.fetchWorkoutLines(from: group, for: "April", for: "testID0") { (workoutLines, error) in
            
            XCTAssertEqual(workoutLines.count, countWorkoutLines)
            XCTAssertEqual(workoutLines[0].text, "test + test")
        }
    }
}
