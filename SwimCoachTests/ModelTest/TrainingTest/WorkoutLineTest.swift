//
//  WorkoutLineTest.swift
//  SwimCoachTests
//
//  Created by Alexandre Goncalves on 13/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import XCTest
@testable import SwimCoach

class WorkoutLineTest: XCTestCase {

    var workoutLine: WorkoutLine!
    
    override func setUp() {
        
        workoutLine = WorkoutLine(text: "test", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID", workoutLineTitle: "titleTest")
        
    }
    func testGivenNil_WhenCreatingWorkoutLine_ThenResultIsNotNil() {
        // Given
        // When
        
        let workoutLine = WorkoutLine()
        
        // Then
        
        XCTAssertNotNil(workoutLine)
    }
    
    
    func testGivenNil_WhenCreatingWorkoutLineWithParameters_ThenResultIsNotNil() {
        // Given
        // When
        
        let workoutLine = WorkoutLine(text: "test", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID", workoutLineTitle: "titleTest")
        
        // Then
        
        XCTAssertNotNil(workoutLine)
    }
    
    
    func testGivenWorkoutLine_WhenCreatingWorkoutLine_ThenPropertiesEqualParameter() {
        // Given
        // When
        
        // Then
        
        XCTAssertEqual(workoutLine.text, "test")
        XCTAssertEqual(workoutLine.zone1, 1.0)
        XCTAssertEqual(workoutLine.zone2, 1.0)
        XCTAssertEqual(workoutLine.zone3, 1.0)
        XCTAssertEqual(workoutLine.zone4, 1.0)
        XCTAssertEqual(workoutLine.zone5, 1.0)
        XCTAssertEqual(workoutLine.zone6, 1.0)
        XCTAssertEqual(workoutLine.zone7, 1.0)
        XCTAssertEqual(workoutLine.ampM, 1.0)
        XCTAssertEqual(workoutLine.coorM, 1.0)
        XCTAssertEqual(workoutLine.endM, 1.0)
        XCTAssertEqual(workoutLine.educ, 1.0)
        XCTAssertEqual(workoutLine.crawl, 1.0)
        XCTAssertEqual(workoutLine.medley, 1.0)
        XCTAssertEqual(workoutLine.spe, 1.0)
        XCTAssertEqual(workoutLine.nageC, 1.0)
        XCTAssertEqual(workoutLine.jbs, 1.0)
        XCTAssertEqual(workoutLine.bras, 1.0)
        XCTAssertEqual(workoutLine.workoutLineID, "testID")
        XCTAssertEqual(workoutLine.workoutLineTitle, "titleTest")
    }
    
    
    func testGivenWorkoutLine_WhenAccessingDictionnary_ThenValuesEqualProperty() {
        // Given
        // When
        
        let dict = workoutLine.dictionnary
        
        // Then
        
        XCTAssertEqual(workoutLine.text, dict["text"] as! String)
        XCTAssertEqual(workoutLine.zone1, dict["zone1"] as! Double)
        XCTAssertEqual(workoutLine.zone2, dict["zone2"] as! Double)
        XCTAssertEqual(workoutLine.zone3, dict["zone3"] as! Double)
        XCTAssertEqual(workoutLine.zone4, dict["zone4"] as! Double)
        XCTAssertEqual(workoutLine.zone5, dict["zone5"] as! Double)
        XCTAssertEqual(workoutLine.zone6, dict["zone6"] as! Double)
        XCTAssertEqual(workoutLine.zone7, dict["zone7"] as! Double)
        XCTAssertEqual(workoutLine.ampM, dict["ampM"] as! Double)
        XCTAssertEqual(workoutLine.coorM, dict["coorM"] as! Double)
        XCTAssertEqual(workoutLine.endM, dict["endM"] as! Double)
        XCTAssertEqual(workoutLine.educ, dict["educ"] as! Double)
        XCTAssertEqual(workoutLine.crawl, dict["crawl"] as! Double)
        XCTAssertEqual(workoutLine.medley, dict["medley"] as! Double)
        XCTAssertEqual(workoutLine.spe, dict["spe"] as! Double)
        XCTAssertEqual(workoutLine.nageC, dict["nageC"] as! Double)
        XCTAssertEqual(workoutLine.jbs, dict["jbs"] as! Double)
        XCTAssertEqual(workoutLine.bras, dict["bras"] as! Double)
        XCTAssertEqual(workoutLine.workoutLineID, dict["workoutLineID"] as! String)
        XCTAssertEqual(workoutLine.workoutLineTitle, dict["workoutLineTitle"] as! String)
        
    }
    
    
    func testGivenCorrectDictionnary_WhenCreatingWorkoutLine_ThenWorkoutLineIsNotNil() {
        // Given
        
        let dictionnary: [String : Any] = ["text" : "testText",
                                           "zone1" : 1.0,
                                           "zone2" : 1.0,
                                           "zone3" : 1.0,
                                           "zone4" : 1.0,
                                           "zone5" : 1.0,
                                           "zone6" : 1.0,
                                           "zone7" : 1.0,
                                           "ampM" : 1.0,
                                           "coorM" : 1.0,
                                           "endM" : 1.0,
                                           "educ" : 1.0,
                                           "crawl" : 1.0,
                                           "medley" : 1.0,
                                           "spe" : 1.0,
                                           "nageC" : 1.0,
                                           "jbs" : 1.0,
                                           "bras" : 1.0,
                                           "workoutLineID" : "testID",
                                           "workoutLineTitle" : "testTitle"
        ]
        
        // When
        
        let workoutLine = WorkoutLine(document: dictionnary)
        
        // Then
        
        XCTAssertNotNil(workoutLine)
        
    }
    
    
    func testGivenWrongDictionnary_WhenCreatingWorkoutLine_ThenWorkoutLineIsNotNil() {
        // Given
        
        let dictionnary: [String : Any] = ["text" : "testText",
                                           "zone1" : 1.0,
                                           "zone2" : 1.0,
                                           "zone3" : 1.0,
                                           "zone4" : 1.0,
                                           "zone5" : 1.0,
                                           "zone6" : 1.0,
                                           "zone7" : 1.0,
                                           "ampM" : 1.0,
                                           "coorM" : 1.0,
                                           "endM" : 1.0,
                                           "educ" : 1.0,
                                           "crawl" : 1.0,
                                           "medley" : 1.0,
                                           "spe" : 1.0,
                                           "nageC" : 1.0,
                                           "jbs" : 1.0,
                                           "bras" : 1.0,
                                           "workoutLineID" : "testID",
                                           "workoutLineTitle" : "testTitle"
        ]
        
        // When
        
        for key in 0...19 {
            var tempDict = dictionnary
            
            switch key {
            case 0:
                tempDict["text"] = 42
                let workoutLine = WorkoutLine(document: tempDict)
                // Then
                
                XCTAssertNil(workoutLine)
                
            case 1:
                tempDict["zone1"] = "test"
                let workoutLine = WorkoutLine(document: tempDict)
                // Then
                
                XCTAssertNil(workoutLine)
                
            case 2:
                tempDict["zone2"] = "test"
                let workoutLine = WorkoutLine(document: tempDict)
                // Then
                
                XCTAssertNil(workoutLine)
                
            case 3:
                tempDict["zone3"] = "test"
                let workoutLine = WorkoutLine(document: tempDict)
                // Then
                
                XCTAssertNil(workoutLine)
                
            case 4:
                tempDict["zone4"] = "test"
                let workoutLine = WorkoutLine(document: tempDict)
                // Then
                
                XCTAssertNil(workoutLine)
                
            case 5:
                tempDict["zone5"] = "test"
                let workoutLine = WorkoutLine(document: tempDict)
                // Then
                
                XCTAssertNil(workoutLine)
                
            case 6:
                tempDict["zone6"] = "test"
                let workoutLine = WorkoutLine(document: tempDict)
                // Then
                
                XCTAssertNil(workoutLine)
                
            case 7:
                tempDict["zone7"] = "test"
                let workoutLine = WorkoutLine(document: tempDict)
                // Then
                
                XCTAssertNil(workoutLine)
                
            case 8:
                tempDict["ampM"] = "test"
                let workoutLine = WorkoutLine(document: tempDict)
                // Then
                
                XCTAssertNil(workoutLine)
                
            case 9:
                tempDict["coorM"] = "test"
                let workoutLine = WorkoutLine(document: tempDict)
                // Then
                
                XCTAssertNil(workoutLine)
                
            case 10:
                tempDict["endM"] = "test"
                let workoutLine = WorkoutLine(document: tempDict)
                // Then
                
                XCTAssertNil(workoutLine)
                
            case 11:
                tempDict["educ"] = "test"
                let workoutLine = WorkoutLine(document: tempDict)
                // Then
                
                XCTAssertNil(workoutLine)
                
            case 12:
                tempDict["crawl"] = "test"
                let workoutLine = WorkoutLine(document: tempDict)
                // Then
                
                XCTAssertNil(workoutLine)
                
            case 13:
                tempDict["medley"] = "test"
                let workoutLine = WorkoutLine(document: tempDict)
                // Then
                
                XCTAssertNil(workoutLine)
                
            case 14:
                tempDict["spe"] = "test"
                let workoutLine = WorkoutLine(document: tempDict)
                // Then
                
                XCTAssertNil(workoutLine)
                
            case 15:
                tempDict["nageC"] = "test"
                let workoutLine = WorkoutLine(document: tempDict)
                // Then
                
                XCTAssertNil(workoutLine)
                
            case 16:
                tempDict["jbs"] = "test"
                let workoutLine = WorkoutLine(document: tempDict)
                // Then
                
                XCTAssertNil(workoutLine)
                
            case 17:
                tempDict["bras"] = "test"
                let workoutLine = WorkoutLine(document: tempDict)
                // Then
                
                XCTAssertNil(workoutLine)
                
            case 18:
                tempDict["workoutLineID"] = 42
                let workoutLine = WorkoutLine(document: tempDict)
                // Then
                
                XCTAssertNil(workoutLine)
                
            case 19:
                tempDict["workoutLineTitle"] = 42
                let workoutLine = WorkoutLine(document: tempDict)
                // Then
                
                XCTAssertNil(workoutLine)
                
            default:
                print("useless case")

            }
        }
    }
    
    
    func testGivenWorkoutLine_WhenAddingDistanceToZone_ThenZoneDistanceChange() {
        // Given
        // When
        
        let distance = 10.0
        for zone in 1...7 {
            switch zone {
            case 1:
                workoutLine.addZ1(distance: distance)
                // Then
                
                XCTAssertEqual(workoutLine.zone1, 10.0)
                
            case 2:
                workoutLine.addZ2(distance: distance)
                // Then
                
                XCTAssertEqual(workoutLine.zone2, distance)
                
            case 3:
                workoutLine.addZ3(distance: distance)
                // Then
                
                XCTAssertEqual(workoutLine.zone3, distance)
                
            case 4:
                workoutLine.addZ4(distance: distance)
                // Then
                
                XCTAssertEqual(workoutLine.zone4, distance)
                
            case 5:
                workoutLine.addZ5(distance: distance)
                // Then
                
                XCTAssertEqual(workoutLine.zone5, distance)
                
            case 6:
                workoutLine.addZ6(distance: distance)
                // Then
                
                XCTAssertEqual(workoutLine.zone6, distance)
                
            case 7:
                workoutLine.addZ7(distance: distance)
                // Then
                
                XCTAssertEqual(workoutLine.zone7, distance)
                
            default:
                print("useless case")
            }
        }
    }
    
    
    func testGivenWorkoutLine_WhenAddingDistanceToMotricity_ThenMotricityDistanceChange() {
        // Given
        // When
        
        let distance = 10.0
        for motri in 1...3 {
            switch motri {
            case 1:
                workoutLine.addAmpM(distance: distance)
                // Then
                
                XCTAssertEqual(workoutLine.ampM, 10.0)
                
            case 2:
                workoutLine.addCoorM(distance: distance)
                // Then
                
                XCTAssertEqual(workoutLine.coorM, distance)
                
            case 3:
                workoutLine.addEndM(distance: distance)
                // Then
                
                XCTAssertEqual(workoutLine.endM, distance)
                
            default:
                print("useless case")
            }
        }
    }
    
    func testGivenWorkout_WhenGettingDistanceByStroke_ThenStrokesDistanceChange() {
        // Given
        // When
        
        let distance = 10.0
        for stroke in 0...2 {
            switch stroke {
            case 0:
                workoutLine.addCrawl(distance: distance)
                // Then
                
                XCTAssertEqual(workoutLine.crawl, 10.0)
                
            case 1:
                workoutLine.addMedley(distance: distance)
                // Then
                
                XCTAssertEqual(workoutLine.medley, 10.0)
                
            case 2:
                workoutLine.addSpe(distance: distance)
                // Then
                
                XCTAssertEqual(workoutLine.spe, 10.0)
                
            default:
                print("Useless case")
            }
        }
    }
    
    func testGivenWorkout_WhenGettingDistanceByExercises_ThenExercicesDistanceChange() {
        // Given
        // When
        
        let distance = 10.0
        for exercise in 0...3 {
            switch exercise {
            case 0:
                workoutLine.addNageC(distance: distance)
                // Then
                
                XCTAssertEqual(workoutLine.nageC, 10.0)
                
            case 1:
                workoutLine.addBras(distance: distance)
                // Then
                
                XCTAssertEqual(workoutLine.bras, 10.0)
                
            case 2:
                workoutLine.addJbs(distance: distance)
                // Then
                
                XCTAssertEqual(workoutLine.jbs, 10.0)
                
            case 3:
                workoutLine.addEduc(distance: distance)
                // Then
                
                XCTAssertEqual(workoutLine.educ, 10.0)
            default:
                print("Useless case")
            }
        }
    }
    

    
    func testGivenWorkoutLine_WhenGettingTitle_ThenResultIsTitle() {
        // Given
        // When
        
        let title = workoutLine.getWorkoutTitle()
        
        // Then
        
        XCTAssertEqual(title, "titleTest")
    }
    
}
