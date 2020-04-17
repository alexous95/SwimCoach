//
//  TrainingViewModelTest.swift
//  SwimCoachTests
//
//  Created by Alexandre Goncalves on 17/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import XCTest
@testable import SwimCoach

class TrainingViewModelTest: XCTestCase {
    
    enum TrainingError : Error {
        case empty
    }
    
    var group: Group!
    var error: TrainingError!
    var databaseWorkout: [String : [String : [Workout]]]!
    var databaseWorkoutLines: [String : [WorkoutLine]]!
    var firestoreWorkoutMock: FirestoreWorkoutMock!
    var firestoreWorkoutErrorMock: FirestoreWorkoutMock!
    var viewModel: TrainingViewModel!
    var viewModelError: TrainingViewModel!
    
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
        viewModel = TrainingViewModel(network: firestoreWorkoutMock)
        viewModelError = TrainingViewModel(network: firestoreWorkoutErrorMock)
    }
    
    
    func testGivenNil_WhenCreatingTrainingViewModel_ThenViewModelIsNotNil() {
        // Given
        // When
        
        let viewModel = TrainingViewModel(network: firestoreWorkoutMock)
        
        // Then
        
        XCTAssertNotNil(viewModel)
    }
    
    
    func testGivenViewModel_WhenFetchingWorkout_ThenWorkoutArrayIsEqualDatabaseWorkout() {
        // Given
        // When
        
        viewModel.fetchWorkout(from: group, for: "April")
        
        // Then
        
        XCTAssertNotNil(viewModel.workouts)
        XCTAssertEqual(viewModel.workouts?.count, databaseWorkout[group.groupName]?["April"]?.count)
        
    }
    
    
    func testGivenViewModelError_WhenFetchingWorkout_ThenWorkoutsIsNil() {
        // Given
        // When
        
        viewModelError.fetchWorkout(from: group, for: "April")
        
        // Then
        
        XCTAssertNil(viewModelError.workouts)
        XCTAssertEqual(viewModelError.error, "error while loading workouts")
    }
    
    
    func testGivenViewModel_WhenGettingNumberOfItem_ThenResultIsArrayCount() {
        // Given
        
        viewModel.fetchWorkout(from: group, for: "April")
        
        // When
        
        let numberOfItem = viewModel.numberOfItem()
        
        // Then
        
        XCTAssertEqual(numberOfItem, databaseWorkout[group.groupName]?["April"]?.count)
    }
    
    
    func testGivenViewModel_WhenGettingNumberOfItem_ThenResultIs0IfWorkoutIsNil() {
        // Given
        // When
        
        let numberOfItem = viewModel.numberOfItem()
        
        // Then
        
        XCTAssertEqual(numberOfItem, 0)
    }
    
    
    func testGivenViewModel_WhenDeletingWorkout_ThenCorrectWorkoutIsDeleted() {
        // Given
        
        let workout = Workout(title: "testTitle" , date: "testDate", workoutID: "testID0", workoutLines: [])
        viewModel.fetchWorkout(from: group, for: "April")
        let countWorkout = viewModel.numberOfItem()
        
        // When
        
        viewModel.deleteWorkout(from: group, for: "April", workout: workout)
        
        // Then
        
        XCTAssertEqual(viewModel.workouts?.count, countWorkout - 1)
        XCTAssertEqual(viewModel.workouts?[0].workoutID, "testID1")
    }
    
    
    func testGivenViewModel_WhenDeletingNonExistingWorkout_ThenNothingHappen() {
        // Given
        
        let workout = Workout(title: "testTitle" , date: "testDate", workoutID: "testID", workoutLines: [])
        viewModel.fetchWorkout(from: group, for: "April")
        let countWorkout = viewModel.numberOfItem()
        
        // When
        
        viewModel.deleteWorkout(from: group, for: "April", workout: workout)
        
        // Then
        
        XCTAssertEqual(viewModel.workouts?.count, countWorkout)
        XCTAssertEqual(viewModel.workouts?[0].workoutID, "testID0")
    }
}
