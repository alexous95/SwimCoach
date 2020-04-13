//
//  WorkoutTest.swift
//  SwimCoachTests
//
//  Created by Alexandre Goncalves on 13/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import XCTest
@testable import SwimCoach

class WorkoutTest: XCTestCase {

    // MARK: - Setup
    
    var workoutLines: [WorkoutLine]!
    var workout: Workout!
    
    override func setUp() {
        
        workoutLines = [WorkoutLine]()
        
        let workoutLine = WorkoutLine(text: "test", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID", workoutLineTitle: "titleTest")
        
        let workoutLine2 = WorkoutLine(text: "test2", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID2", workoutLineTitle: "titleTest2")
        
        workoutLines.append(workoutLine)
        workoutLines.append(workoutLine2)
        
        workout = Workout(title: "testTitle", date: "testDate", workoutID: "testID", workoutLines: workoutLines)
        
    }
    
    // MARK: - Init tests
    
    
    func testGivenNil_WhenCreatingWorkout_ThenResultIsNotNil() {
        // Given
        // When
        
        let workout = Workout()
        
        // Then
        
        XCTAssertNotNil(workout)
        
    }
    
    
    func testGivenNil_WhenCreatingWorkoutWithParameters_ThenResultIsNotNil() {
        // Given
        // When
        
        let workout = Workout(title: "test", date: "testDate", workoutID: "testID")
        
        // Then
        
        XCTAssertNotNil(workout)
    }
    
    func testGivenWorkout_WhenInitWorkout_ThenWorkoutPropertyEqualsInit() {
        // Given
        // When
        
        // Then
        
        XCTAssertEqual(workout.title, "testTitle")
        XCTAssertEqual(workout.date, "testDate")
        XCTAssertEqual(workout.workoutID, "testID")
        XCTAssertNotNil(workout.workoutLines)
    }
    
    
    func testGivenWorkout_WhenAccessingDictionnary_ThenValuesEqualProperty() {
        // Given
        // This part is in the setup methode
        
        // When
        
        let dict = workout.dictionnary
        
        // Then
        
        XCTAssertEqual(workout.title, dict["title"] as! String)
        XCTAssertEqual(workout.date, dict["date"] as! String)
        XCTAssertEqual(workout.workoutID, dict["workoutID"] as! String)
    }
    
    
    func testGivenWrongTitle_WhenCreatingWorkoutFromDictionnary_ThenWorkoutIsNil() {
        // Given
        
        let dictionnary: [String : Any] = ["title" : 42,
                                           "date" : "testDate",
                                           "workoutID" : "testID"
        ]
        
        // When
        
        let workout = Workout(document: dictionnary)
        
        // Then
        
        XCTAssertNil(workout)
    }
    
    
    func testGivenWrongDate_WhenCreatingWorkoutFromDictionnary_ThenWorkoutIsNil() {
        // Given
        
        let dictionnary: [String : Any] = ["title" : "testTitle",
                                           "date" : 42,
                                           "workoutID" : "testID"
        ]
        
        // When
        
        let workout = Workout(document: dictionnary)
        
        // Then
        
        XCTAssertNil(workout)
    }
    
    func testGivenWrongID_WhenCreatingWorkoutFromDictionnary_ThenWorkoutIsNil() {
        // Given
        
        let dictionnary: [String : Any] = ["title" : "testTitle",
                                           "date" : "testDate",
                                           "workoutID" : 42
        ]
        
        // When
        
        let workout = Workout(document: dictionnary)
        
        // Then
        
        XCTAssertNil(workout)
    }
    
    // MARK: - Get Tests
    
    func testGivenWorkoutLine_WhenCreatingWorkout_ThenWorkoutIsNotNil() {
        // Given
        // When

        // Then

        XCTAssertNotNil(workout.workoutLines)
    }
    
    
    func testGivenWorkoutLine_WhenCreatingWorkout_ThenWorkoutLinesAreEqual() {
        // Given
        // When
        
        // Then
        
        XCTAssertEqual(workout.workoutLines[0].text, "test")
        XCTAssertEqual(workout.workoutLines[0].zone1, 1.0)
        XCTAssertEqual(workout.workoutLines[0].zone2, 1.0)
        XCTAssertEqual(workout.workoutLines[0].zone3, 1.0)
        XCTAssertEqual(workout.workoutLines[0].zone4, 1.0)
        XCTAssertEqual(workout.workoutLines[0].zone5, 1.0)
        XCTAssertEqual(workout.workoutLines[0].zone6, 1.0)
        XCTAssertEqual(workout.workoutLines[0].zone7, 1.0)
        XCTAssertEqual(workout.workoutLines[0].ampM, 1.0)
        XCTAssertEqual(workout.workoutLines[0].endM, 1.0)
        XCTAssertEqual(workout.workoutLines[0].coorM, 1.0)
        XCTAssertEqual(workout.workoutLines[0].crawl, 1.0)
        XCTAssertEqual(workout.workoutLines[0].medley, 1.0)
        XCTAssertEqual(workout.workoutLines[0].spe, 1.0)
        XCTAssertEqual(workout.workoutLines[0].educ, 1.0)
        XCTAssertEqual(workout.workoutLines[0].nageC, 1.0)
        XCTAssertEqual(workout.workoutLines[0].bras, 1.0)
        XCTAssertEqual(workout.workoutLines[0].jbs, 1.0)
        XCTAssertEqual(workout.workoutLines[0].workoutLineID, "testID")
        XCTAssertEqual(workout.workoutLines[0].workoutLineTitle, "titleTest")
    }
    
    // MARK: - Get Zone Distance Tests
    
    func testGivenWorkout_WhenGettingDistanceZone_ThenResultIs2() {
        // Given
        
        // When
        for zone in 0...7 {
            var distance = 0.0
            switch zone {
            case 0:
                distance = workout.getDistance()
                // Then
                
                XCTAssertEqual(distance, 14.0)
            case 1:
                distance = workout.getDistanceZ1()
                // Then
                
                XCTAssertEqual(distance, 2.0)
                
            case 2:
                distance = workout.getDistanceZ2()
                // Then
                
                XCTAssertEqual(distance, 2.0)
                
            case 3:
                distance = workout.getDistanceZ3()
                // Then
                
                XCTAssertEqual(distance, 2.0)
                
            case 4:
                distance = workout.getDistanceZ4()
                // Then
                
                XCTAssertEqual(distance, 2.0)
                
            case 5:
                distance = workout.getDistanceZ5()
                // Then
                
                XCTAssertEqual(distance, 2.0)
                
            case 6:
                distance = workout.getDistanceZ6()
                // Then
                
                XCTAssertEqual(distance, 2.0)
                
            case 7:
                distance = workout.getDistanceZ7()
                // Then
                
                XCTAssertEqual(distance, 2.0)
                
            default:
                print("erreur !!!!!!!!!!!!")
            }
        }
    }
    
    // MARK: - Get Motricity Distance Tests
    
    func testGivenWorkout_WhenGettingDistanceMotricity_ThenResultIsTheSumOfMotricity() {
        // Given
        //When
        
        for motri in 0...2 {
            var distance = 0.0
            switch motri {
            case 0:
                distance = workout.getDistanceAmpM()
                // Then
                
                XCTAssertEqual(distance, 2.0)
                
            case 1:
                distance = workout.getDistanceCoorM()
                // Then
                
                XCTAssertEqual(distance, 2.0)
                
            case 2:
                distance = workout.getDistanceEndM()
                // Then
                
                XCTAssertEqual(distance, 2.0)
                
            default:
                print("Useless case")
            }
        }
    }
    
    // MARK: - Get Strokes Distance Tests
    
    func testGivenWorkout_WhenGettingDistanceByStroke_ThenResultIsTheSumOfStrokes() {
        // Given
        // When
        
        for stroke in 0...2 {
            var distance = 0.0
            switch stroke {
            case 0:
                distance = workout.getDistanceCrawl()
                // Then
                
                XCTAssertEqual(distance, 2.0)
                
            case 1:
                distance = workout.getDistanceMedley()
                // Then
                
                XCTAssertEqual(distance, 2.0)
                
            case 2:
                distance = workout.getDistanceSpe()
                // Then
                
                XCTAssertEqual(distance, 2.0)
                
            default:
                print("Useless case")
            }
        }
    }
    
    // MARK: - Get Exercice Distance Tests
    
    func testGivenWorkout_WhenGettingDistanceByExercise_ThenResultIsTheSumOfExercises() {
        // Given
        // When
        
        for exercices in 0...3 {
            var distance = 0.0
            switch exercices {
            case 0:
                distance = workout.getDistanceNageC()
                // Then
                
                XCTAssertEqual(distance, 2.0)
                
            case 1:
                distance = workout.getDistanceJbs()
                // Then
                
                XCTAssertEqual(distance, 2.0)
                
            case 2:
                distance = workout.getDistanceBras()
                // Then
                
                XCTAssertEqual(distance, 2.0)
                
            case 3:
                distance = workout.getDistanceEduc()
                    // Then
                
                XCTAssertEqual(distance, 2.0)
                
            default:
                print("Useless case")
            }
        }
    }
    
    // MARK: - Get Description Test
    
    func testGivenWorkout_WhenGettingDescription_ThenResultIsTheDescriptionOfAllLines() {
        // Given
        // When
        
        let description = workout.description()
        
        // Then
        
        XCTAssertEqual(description, ["titleTest\n \ntest", "titleTest2\n \ntest2"])
    }
    
}
