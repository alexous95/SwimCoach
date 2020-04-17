//
//  DetailWorkoutViewModelTest.swift
//  SwimCoachTests
//
//  Created by Alexandre Goncalves on 17/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import XCTest
@testable import SwimCoach

class DetailWorkoutViewModelTest: XCTestCase {

    var workout: Workout!
    var viewModel: DetailWorkoutViewModel!
    
    func createWorkoutLines() -> [WorkoutLine] {
        let workoutLine = WorkoutLine(text: "test", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID", workoutLineTitle: "titleTest")
        
        let workoutLine2 = WorkoutLine(text: "test2", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID2", workoutLineTitle: "titleTest2")
        
        let workoutLines = [workoutLine, workoutLine2]
        
        return workoutLines
    }
    
    func createWorkout() -> Workout {
        
        let workoutLines = createWorkoutLines()
        let workout = Workout(title: "testTitle", date: "testDate", workoutID: "testID", workoutLines: workoutLines)
        
        return workout
    }
    
    override func setUp() {
        workout = createWorkout()
        viewModel = DetailWorkoutViewModel(workout: workout)
    }
    
    
    func testGivenNil_WhenCreatingViewModel_ThenViewModelIsNotNil() {
        // Given
        // When
        
        let viewModel = DetailWorkoutViewModel(workout: workout)
        
        // Then
        
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel.workout.title, workout.title)
        XCTAssertEqual(viewModel.workout.date, workout.date)
        XCTAssertEqual(viewModel.workout.workoutID, workout.workoutID)
    }

    
    
    func testGivenViewModel_WhenGettingPercentageZ1_ThenResultIsStringZ1DividedTotalDistance() {
        // Given
        var distance = ""
        
        // When
        
        for test in 1...17 {
            switch test {
                // Then
                
            case 1:
                distance = viewModel.getPercentageZ1()
                XCTAssertEqual(distance, String(format: "%.1F", viewModel.workout.getDistanceZ1() / viewModel.workout.getDistance() * 100) )
            case 2:
                distance = viewModel.getPercentageZ2()
                XCTAssertEqual(distance, String(format: "%.1F", viewModel.workout.getDistanceZ2() / viewModel.workout.getDistance() * 100) )
            case 3:
                distance = viewModel.getPercentageZ3()
                XCTAssertEqual(distance, String(format: "%.1F", viewModel.workout.getDistanceZ3() / viewModel.workout.getDistance() * 100) )
            case 4:
                distance = viewModel.getPercentageZ4()
                XCTAssertEqual(distance, String(format: "%.1F", viewModel.workout.getDistanceZ4() / viewModel.workout.getDistance() * 100) )
            case 5:
                distance = viewModel.getPercentageZ5()
                XCTAssertEqual(distance, String(format: "%.1F", viewModel.workout.getDistanceZ5() / viewModel.workout.getDistance() * 100) )
            case 6:
                distance = viewModel.getPercentageZ6()
                XCTAssertEqual(distance, String(format: "%.1F", viewModel.workout.getDistanceZ6() / viewModel.workout.getDistance() * 100) )
            case 7:
                distance = viewModel.getPercentageZ7()
                XCTAssertEqual(distance, String(format: "%.1F", viewModel.workout.getDistanceZ7() / viewModel.workout.getDistance() * 100) )
            case 8:
                distance = viewModel.getPercentageAmpM()
                XCTAssertEqual(distance, String(format: "%.1F", viewModel.workout.getDistanceAmpM() / viewModel.workout.getDistance() * 100) )
            case 9:
                distance = viewModel.getPercentageCoorM()
                XCTAssertEqual(distance, String(format: "%.1F", viewModel.workout.getDistanceCoorM() / viewModel.workout.getDistance() * 100) )
            case 10:
                distance = viewModel.getPercentageEndM()
                XCTAssertEqual(distance, String(format: "%.1F", viewModel.workout.getDistanceEndM() / viewModel.workout.getDistance() * 100) )
            case 11:
                distance = viewModel.getPercentageEduc()
                XCTAssertEqual(distance, String(format: "%.1F", viewModel.workout.getDistanceEduc() / viewModel.workout.getDistance() * 100) )
            case 12:
                distance = viewModel.getPercentageCrawl()
                XCTAssertEqual(distance, String(format: "%.1F", viewModel.workout.getDistanceCrawl() / viewModel.workout.getDistance() * 100) )
            case 13:
                distance = viewModel.getPercentageMedley()
                XCTAssertEqual(distance, String(format: "%.1F", viewModel.workout.getDistanceMedley() / viewModel.workout.getDistance() * 100) )
            case 14:
                distance = viewModel.getPercentageSpe()
                XCTAssertEqual(distance, String(format: "%.1F", viewModel.workout.getDistanceSpe() / viewModel.workout.getDistance() * 100) )
            case 15:
                distance = viewModel.getPercentageNageC()
                XCTAssertEqual(distance, String(format: "%.1F", viewModel.workout.getDistanceNageC() / viewModel.workout.getDistance() * 100) )
            case 16:
                distance = viewModel.getPercentageJbs()
                XCTAssertEqual(distance, String(format: "%.1F", viewModel.workout.getDistanceJbs() / viewModel.workout.getDistance() * 100) )
            case 17:
                distance = viewModel.getPercentageBras()
                XCTAssertEqual(distance, String(format: "%.1F", viewModel.workout.getDistanceBras() / viewModel.workout.getDistance() * 100) )
            default:
                print("Useless case")
            }
        }
    }
    
    
    func testGivenViewModel_WhenGettingText_ThenTextIsFormatedCorrectly() {
        // Given
        
        var text = ""
        
        // When
        
        text = viewModel.getWorkoutText()
        
        // Then
        
        XCTAssertEqual(text, "titleTest\n \ntest\n \ntitleTest2\n \ntest2")
        
    }
}
