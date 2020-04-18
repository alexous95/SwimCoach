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
    
   
    var database = DatabaseMock()
    var firestoreWorkoutMock: FirestoreWorkoutMock!
    var firestoreWorkoutErrorMock: FirestoreWorkoutMock!
    var viewModel: AddWorkoutLineDetailViewModel!
    var viewModelError: AddWorkoutLineDetailViewModel!
    let dateFormatter = DateFormatter()

    override func setUp() {
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "FR-fr")
        
        database.initDatabase()
        firestoreWorkoutMock = FirestoreWorkoutMock(databaseWorkout: database.databaseWorkout, databaseWorkoutLines: database.databaseWorkoutLines)
        firestoreWorkoutErrorMock = FirestoreWorkoutMock(databaseWorkout: database.databaseWorkout, databaseWorkoutLines: database.databaseWorkoutLines, error: database.error)
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
    
    
    func testGivenViewModel_WhenSavingLines_ThenLinesAreSaved() {
        // Given
        let workoutLine = WorkoutLine(text: "test", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID", workoutLineTitle: "titleTest")
        
        let workoutLine2 = WorkoutLine(text: "test2", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID42", workoutLineTitle: "titleTest2")
        
        viewModel.temporaryWorkoutLine = workoutLine
        viewModel.workoutLine = workoutLine2
        
        // When
        
        viewModel.save(for: database.group, for: "April", workout: database.workout)
        
        // Then
        
        XCTAssertEqual(viewModel.workoutLine.workoutLineID, viewModel.temporaryWorkoutLine.workoutLineID)
    }
    
    
    func testGivenViewModel_WhenPreparingForDisplay_ThenWorkoutLinesAreCorrectlyInit() {
        // Given
        
        let workoutLine = WorkoutLine(text: "test", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID", workoutLineTitle: "titleTest")
        
        let workoutLine2 = WorkoutLine(text: "test2", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID42", workoutLineTitle: "titleTest2")
        
        viewModel.temporaryWorkoutLine = workoutLine
        viewModel.workoutLine = workoutLine2
        
        // When
        
        viewModel.prepareForDisplay()
        
        // Then
        
        XCTAssertEqual(viewModel.workoutLine.workoutLineID, viewModel.temporaryWorkoutLine.workoutLineID)
        XCTAssertEqual(viewModel.workoutLine.text, viewModel.temporaryWorkoutLine.text)
        XCTAssertEqual(viewModel.workoutLine.zone1, viewModel.temporaryWorkoutLine.zone1)
        XCTAssertEqual(viewModel.workoutLine.zone2, viewModel.temporaryWorkoutLine.zone2)
        XCTAssertEqual(viewModel.workoutLine.zone3, viewModel.temporaryWorkoutLine.zone3)
        XCTAssertEqual(viewModel.workoutLine.zone4, viewModel.temporaryWorkoutLine.zone4)
        XCTAssertEqual(viewModel.workoutLine.zone5, viewModel.temporaryWorkoutLine.zone5)
        XCTAssertEqual(viewModel.workoutLine.zone6, viewModel.temporaryWorkoutLine.zone6)
        XCTAssertEqual(viewModel.workoutLine.zone7, viewModel.temporaryWorkoutLine.zone7)
        XCTAssertEqual(viewModel.workoutLine.ampM, viewModel.temporaryWorkoutLine.ampM)
        XCTAssertEqual(viewModel.workoutLine.coorM, viewModel.temporaryWorkoutLine.coorM)
        XCTAssertEqual(viewModel.workoutLine.endM, viewModel.temporaryWorkoutLine.endM)
        XCTAssertEqual(viewModel.workoutLine.educ, viewModel.temporaryWorkoutLine.educ)
        XCTAssertEqual(viewModel.workoutLine.crawl, viewModel.temporaryWorkoutLine.crawl)
        XCTAssertEqual(viewModel.workoutLine.medley, viewModel.temporaryWorkoutLine.medley)
        XCTAssertEqual(viewModel.workoutLine.spe, viewModel.temporaryWorkoutLine.spe)
        XCTAssertEqual(viewModel.workoutLine.nageC, viewModel.temporaryWorkoutLine.jbs)
        XCTAssertEqual(viewModel.workoutLine.jbs, viewModel.temporaryWorkoutLine.jbs)
        XCTAssertEqual(viewModel.workoutLine.bras, viewModel.temporaryWorkoutLine.bras)
        XCTAssertEqual(viewModel.workoutLine.workoutLineTitle, viewModel.temporaryWorkoutLine.workoutLineTitle)
    }
    
    
    func testGivenViewModel_WhenGettingZoneFunction_ThenRightFucntionIsCalled() {
        // Given
        
        let workoutLine = WorkoutLine(text: "test", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID", workoutLineTitle: "titleTest")
        
        viewModel.temporaryWorkoutLine = workoutLine
        
        // When
        
        for choice in 1...7 {
            let returnFunc = viewModel.chooseFunc(from: choice)
            
            switch choice {
            case 1:
                viewModel.temporaryWorkoutLine.addZ1(distance: 2.0)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.zone1, 2.0)
                returnFunc(7)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.zone1, 7.0)
            case 2:
                viewModel.temporaryWorkoutLine.addZ2(distance: 2.0)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.zone2, 2.0)
                returnFunc(7)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.zone2, 7.0)
            case 3:
                viewModel.temporaryWorkoutLine.addZ3(distance: 2.0)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.zone3, 2.0)
                returnFunc(7)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.zone3, 7.0)
            case 4:
                viewModel.temporaryWorkoutLine.addZ4(distance: 2.0)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.zone4, 2.0)
                returnFunc(7)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.zone4, 7.0)
            case 5:
                viewModel.temporaryWorkoutLine.addZ5(distance: 2.0)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.zone5, 2.0)
                returnFunc(7)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.zone5, 7.0)
            case 6:
                viewModel.temporaryWorkoutLine.addZ6(distance: 2.0)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.zone6, 2.0)
                returnFunc(7)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.zone6, 7.0)
            case 7:
                viewModel.temporaryWorkoutLine.addZ7(distance: 2.0)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.zone7, 2.0)
                returnFunc(7)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.zone7, 7.0)
            default:
                print("Default")
            }
        }
    }
    
    func testGivenViewModel_WhenGettingMotricityFunction_ThenRightFucntionIsCalled() {
        // Given
        
        let workoutLine = WorkoutLine(text: "test", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID", workoutLineTitle: "titleTest")
        
        viewModel.temporaryWorkoutLine = workoutLine
        
        // When
        
        for choice in 10...12 {
            let returnFunc = viewModel.chooseFunc(from: choice)
            
            switch choice {
            case 10:
                viewModel.temporaryWorkoutLine.addAmpM(distance: 2.0)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.ampM, 2.0)
                returnFunc(7)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.ampM, 7.0)
            case 11:
                viewModel.temporaryWorkoutLine.addCoorM(distance: 2.0)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.coorM, 2.0)
                returnFunc(7)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.coorM, 7.0)
            case 12:
                viewModel.temporaryWorkoutLine.addEndM(distance: 2.0)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.endM, 2.0)
                returnFunc(7)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.endM, 7.0)
            default:
                print("Default")
            }
        }
    }
    
    func testGivenViewModel_WhenGettingStrokeFunction_ThenRightFucntionIsCalled() {
        // Given
        
        let workoutLine = WorkoutLine(text: "test", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID", workoutLineTitle: "titleTest")
        
        viewModel.temporaryWorkoutLine = workoutLine
        
        // When
        
        for choice in 20...22 {
            let returnFunc = viewModel.chooseFunc(from: choice)
            
            switch choice {
            case 20:
                viewModel.temporaryWorkoutLine.addCrawl(distance: 2.0)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.crawl, 2.0)
                returnFunc(7)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.crawl, 7.0)
            case 21:
                viewModel.temporaryWorkoutLine.addMedley(distance: 2.0)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.medley, 2.0)
                returnFunc(7)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.medley, 7.0)
            case 22:
                viewModel.temporaryWorkoutLine.addSpe(distance: 2.0)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.spe, 2.0)
                returnFunc(7)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.spe, 7.0)
            default:
                print("Default")
            }
        }
    }
    
    func testGivenViewModel_WhenGettingExerciceFunction_ThenRightFucntionIsCalled() {
        // Given
        
        let workoutLine = WorkoutLine(text: "test", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID", workoutLineTitle: "titleTest")
        
        viewModel.temporaryWorkoutLine = workoutLine
        
        // When
        
        for choice in 30...33 {
            let returnFunc = viewModel.chooseFunc(from: choice)
            
            switch choice {
            case 30:
                viewModel.temporaryWorkoutLine.addNageC(distance: 2.0)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.nageC, 2.0)
                returnFunc(7)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.nageC, 7.0)
            case 31:
                viewModel.temporaryWorkoutLine.addEduc(distance: 2.0)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.educ, 2.0)
                returnFunc(7)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.educ, 7.0)
            case 32:
                viewModel.temporaryWorkoutLine.addJbs(distance: 2.0)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.jbs, 2.0)
                returnFunc(7)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.jbs, 7.0)
            case 33:
                viewModel.temporaryWorkoutLine.addBras(distance: 2.0)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.bras, 2.0)
                returnFunc(7)
                XCTAssertEqual(viewModel.temporaryWorkoutLine.bras, 7.0)
            default:
                print("Default")
            }
        }
    }
    
    func testGivenViewModel_WhenGettingDefautFunction_ThenNothingChange() {
        // Given
        
        let workoutLine = WorkoutLine(text: "test", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID", workoutLineTitle: "titleTest")
        
        let workoutLine2 = WorkoutLine(text: "test", zone1: 1.0, zone2: 1.0, zone3: 1.0, zone4: 1.0, zone5: 1.0, zone6: 1.0, zone7: 1.0, ampM: 1.0, coorM: 1.0, endM: 1.0, educ: 1.0, crawl: 1.0, medley: 1.0, spe: 1.0, nageC: 1.0, jbs: 1.0, bras: 1.0, workoutLineID: "testID", workoutLineTitle: "titleTest")
        
        viewModel.temporaryWorkoutLine = workoutLine
        
        // When
        
        let resultFunc = viewModel.chooseFunc(from: 40)
        
        // Then
        
        resultFunc(10)
        
        XCTAssertEqual(workoutLine2.workoutLineID, viewModel.temporaryWorkoutLine.workoutLineID)
        XCTAssertEqual(workoutLine2.text, viewModel.temporaryWorkoutLine.text)
        XCTAssertEqual(workoutLine2.zone1, viewModel.temporaryWorkoutLine.zone1)
        XCTAssertEqual(workoutLine2.zone2, viewModel.temporaryWorkoutLine.zone2)
        XCTAssertEqual(workoutLine2.zone3, viewModel.temporaryWorkoutLine.zone3)
        XCTAssertEqual(workoutLine2.zone4, viewModel.temporaryWorkoutLine.zone4)
        XCTAssertEqual(workoutLine2.zone5, viewModel.temporaryWorkoutLine.zone5)
        XCTAssertEqual(workoutLine2.zone6, viewModel.temporaryWorkoutLine.zone6)
        XCTAssertEqual(workoutLine2.zone7, viewModel.temporaryWorkoutLine.zone7)
        XCTAssertEqual(workoutLine2.ampM, viewModel.temporaryWorkoutLine.ampM)
        XCTAssertEqual(workoutLine2.coorM, viewModel.temporaryWorkoutLine.coorM)
        XCTAssertEqual(workoutLine2.endM, viewModel.temporaryWorkoutLine.endM)
        XCTAssertEqual(workoutLine2.educ, viewModel.temporaryWorkoutLine.educ)
        XCTAssertEqual(workoutLine2.crawl, viewModel.temporaryWorkoutLine.crawl)
        XCTAssertEqual(workoutLine2.medley, viewModel.temporaryWorkoutLine.medley)
        XCTAssertEqual(workoutLine2.spe, viewModel.temporaryWorkoutLine.spe)
        XCTAssertEqual(workoutLine2.nageC, viewModel.temporaryWorkoutLine.jbs)
        XCTAssertEqual(workoutLine2.jbs, viewModel.temporaryWorkoutLine.jbs)
        XCTAssertEqual(workoutLine2.bras, viewModel.temporaryWorkoutLine.bras)
        XCTAssertEqual(workoutLine2.workoutLineTitle, viewModel.temporaryWorkoutLine.workoutLineTitle)
        
    }
}
