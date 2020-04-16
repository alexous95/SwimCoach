//
//  MonthViewModelTest.swift
//  SwimCoachTests
//
//  Created by Alexandre Goncalves on 16/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import XCTest
@testable import SwimCoach

class MonthViewModelTest: XCTestCase {

   
    func testGivenNil_WhenCreatingViewModel_ThenResultNotNil() {
        // Given
        // When
        
        let viewModel = MonthViewModel()
        
        // Then
        
        XCTAssertNotNil(viewModel)
    }
    
    
    func testGivenViewModel_WhenCheckingMonthCount_ThenResultIs12() {
        // Given
        
        let viewModel = MonthViewModel()
        
        // When
        
        let count = viewModel.months.count
        
        // Then
        
        XCTAssertEqual(count, 12)
    }
    
    func testGivenViewModel_WhenCheckingNumberOfItem_ThenResultIs12() {
        // Given
        
        let viewModel = MonthViewModel()
        
        // When
        
        let count = viewModel.numberOfItem()
        
        // Then
        
        XCTAssertEqual(count, 12)
    }
}
