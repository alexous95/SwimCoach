//
//  GroupViewModelTest.swift
//  SwimCoachTests
//
//  Created by Alexandre Goncalves on 13/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import XCTest
@testable import SwimCoach

class GroupViewModelTest: XCTestCase {

    enum GroupError: Error {
        case empty
    }
    
    var viewModelError: GroupViewModel!
    var fetchedGroups: [Group]!
    var newGroups: [Group]!
    var error: GroupError!
    
    override func setUp() {
        
        fetchedGroups = []
        error = GroupError.empty
        
        for index in 0...4 {
            let group = Group(groupName: "\(index)")
            fetchedGroups.append(group)
        }
        
        viewModelError = GroupViewModel(manager: FirestoreGroupMock(groups: fetchedGroups, error: error))
    }

    
    func testGivenNil_WhenCreatingViewModel_ThenViewModelIsNotNil() {
        // Given
        // When
        
        let viewModel = GroupViewModel()
        
        // Then
        
        XCTAssertNotNil(viewModel)
    }
    
    
    func testGivenNil_WhenCreatingViewModelWithParameters_ThenViewModelIsNotNil() {
        // Given
        // When
        
        let viewModel = GroupViewModel(manager: FirestoreGroupMock(groups: fetchedGroups))
        
        // Then
        
        XCTAssertNotNil(viewModel)
    }
    
    
    func testGivenViewModel_WhenFetchingGroupAndError_ThenGroupArrayIsNil() {
        // Given
        
        let viewModel = GroupViewModel(manager: FirestoreGroupMock(groups: fetchedGroups, error: error))
        
        // When
        
        viewModel.fetchGroup()
        
        // Then
        
        XCTAssertNil(viewModel.groups)
    }
    
    
    func testGivenViewModel_WhenFetchingGroup_ThenGroupArrayIsNotEmpty() {
        // Given
        
        let viewModel = GroupViewModel(manager: FirestoreGroupMock(groups: fetchedGroups))
        
        // When
        
        viewModel.fetchGroup()
        
        // Then
        
        XCTAssertNotNil(viewModel.groups)
        XCTAssertEqual(viewModel.groups?.count, 5)
    }
    
    
    func testGivenViewModel_WhenGettingNumberOfItemWithError_ThenNumberIs0() {
        // Given
        
        let viewModel = GroupViewModel(manager: FirestoreGroupMock(groups: fetchedGroups, error: error))
        
        // When
        
        let number = viewModel.numberOfItem()
        
        // Then
        
        XCTAssertNil(viewModel.groups)
        XCTAssertEqual(number, 0)
    }
    
    
    func testGivenViewModel_WhenGettingNumberOfItem_ThenNumberIsGroupsCount() {
        // Given
        
        let viewModel = GroupViewModel(manager: FirestoreGroupMock(groups: fetchedGroups))
        
        // When
        
        viewModel.fetchGroup()
        let number = viewModel.numberOfItem()
        
        // Then
        
        XCTAssertNotNil(viewModel.groups)
        XCTAssertEqual(number, 5)
    }
    
    
    func testGivenViewModel_WhenAddingGroup_ThenGroupsCountPlus1() {
        // Given
        
        let viewModel = GroupViewModel(manager: FirestoreGroupMock(groups: fetchedGroups))
        let groupName = "test3"
        
        // When
        
        viewModel.addGroup(groupName: groupName)
        
        // Then
        
        XCTAssertNotNil(viewModel.groups)
        XCTAssertEqual(viewModel.groups?.count, 6)
    }
    
    
    func testGivenViewModel_WhenDeletingGroup_ThenGroupsCountMinus1() {
        // Given
        
        let viewModel = GroupViewModel(manager: FirestoreGroupMock(groups: fetchedGroups))
        let group = Group(groupName: "1")
        
        // When
        
        viewModel.deleteGroup(group: group)
        
        // Then
        
        XCTAssertNotNil(viewModel.groups)
        XCTAssertEqual(viewModel.groups?.count, 4)
    }
}
