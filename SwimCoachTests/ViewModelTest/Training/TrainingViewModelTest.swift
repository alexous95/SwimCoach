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
    
    var database = DatabaseMock()
    var firestoreWorkoutMock: FirestoreWorkoutMock!
    var firestoreWorkoutErrorMock: FirestoreWorkoutMock!
    var viewModel: TrainingViewModel!
    var viewModelError: TrainingViewModel!
    
    
    override func setUp() {
        database.initDatabase()
        firestoreWorkoutMock = FirestoreWorkoutMock(databaseWorkout: database.databaseWorkout, databaseWorkoutLines: database.databaseWorkoutLines)
        firestoreWorkoutErrorMock = FirestoreWorkoutMock(databaseWorkout: database.databaseWorkout, databaseWorkoutLines: database.databaseWorkoutLines, error: database.error)
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
        
        viewModel.fetchWorkout(from: database.group, for: "April")
        
        // Then
        
        XCTAssertNotNil(viewModel.workouts)
        XCTAssertEqual(viewModel.workouts?.count, database.databaseWorkout[database.group.groupName]?["April"]?.count)
        
    }
    
    
    func testGivenViewModelError_WhenFetchingWorkout_ThenWorkoutsIsNil() {
        // Given
        // When
        
        viewModelError.fetchWorkout(from: database.group, for: "April")
        
        // Then
        
        XCTAssertNil(viewModelError.workouts)
        XCTAssertEqual(viewModelError.error, "error while loading workouts")
    }
    
    
    func testGivenViewModel_WhenGettingNumberOfItem_ThenResultIsArrayCount() {
        // Given
        
        viewModel.fetchWorkout(from: database.group, for: "April")
        
        // When
        
        let numberOfItem = viewModel.numberOfItem()
        
        // Then
        
        XCTAssertEqual(numberOfItem, database.databaseWorkout[database.group.groupName]?["April"]?.count)
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
        viewModel.fetchWorkout(from: database.group, for: "April")
        let countWorkout = viewModel.numberOfItem()
        
        // When
        
        viewModel.deleteWorkout(from: database.group, for: "April", workout: workout)
        
        // Then
        
        XCTAssertEqual(viewModel.workouts?.count, countWorkout - 1)
        XCTAssertEqual(viewModel.workouts?[0].workoutID, "testID1")
    }
    
    
    func testGivenViewModel_WhenDeletingNonExistingWorkout_ThenNothingHappen() {
        // Given
        
        let workout = Workout(title: "testTitle" , date: "testDate", workoutID: "testID", workoutLines: [])
        viewModel.fetchWorkout(from: database.group, for: "April")
        let countWorkout = viewModel.numberOfItem()
        
        // When
        
        viewModel.deleteWorkout(from: database.group, for: "April", workout: workout)
        
        // Then
        
        XCTAssertEqual(viewModel.workouts?.count, countWorkout)
        XCTAssertEqual(viewModel.workouts?[0].workoutID, "testID0")
    }
}
