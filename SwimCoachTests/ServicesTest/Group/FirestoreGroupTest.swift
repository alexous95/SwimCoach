//
//  FirestoreGroupTest.swift
//  SwimCoachTests
//
//  Created by Alexandre Goncalves on 13/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import XCTest
@testable import SwimCoach

class FirestoreGroupTest: XCTestCase {

    enum GroupError: Error {
        case empty
    }
    
    var fetchedGroups: [Group]!
    var newGroups: [Group]!
    var error: GroupError!
    
    
    override func setUp() {
        
        fetchedGroups = [Group(groupName: "test1"), Group(groupName: "test2")]
        newGroups = [Group]()
        error = GroupError.empty
        
    }
    
    
    func testGivenGroupService_WhenFetchingGroupsWithError_ThenArrayIsEmpty() {
        // Given
        
        let groupManager = FirestoreGroupMock(groups: newGroups, error: error)
        let expectation = XCTestExpectation(description: "Loading group")
        
        // When
        
        groupManager.fetchGroup { (groups, error) in
            
            // Then
            
            XCTAssertNotNil(error)
            XCTAssertEqual(groups.count, self.newGroups.count)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGivenGroupService_WhenFetchingGroupWithNoError_ThenArrayIsNotEmpty() {
        // Given
        
        let groupManager = FirestoreGroupMock(groups: fetchedGroups)
        let expectation = XCTestExpectation(description: "Loading group")
        
        // When
        
        groupManager.fetchGroup { (groups, error) in
            self.newGroups = groups
            
            // Then
            
            XCTAssertEqual(groups.count, self.newGroups.count)
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    
    func testGivenGroupService_WhenAddingGroup_ThenGroupIsAdded() {
        // Given
        
        let groupManager = FirestoreGroupMock(groups: fetchedGroups)
        let group = Group(groupName: "test3")
        
        // When
        
        groupManager.addGroup(group: group)
        
        // Then
        
        XCTAssertEqual(groupManager.groups.count, 3)
    }
    
    
    func testGivenGroupService_WhenDeletingGroup_ThenGroupIsDeleted() {
        // Given
        
        let groupManager = FirestoreGroupMock(groups: fetchedGroups)
        let group = Group(groupName: "test1")
        
        // When
        
        groupManager.deleteGroup(group: group)
        
        // Then
        
        XCTAssertEqual(groupManager.groups.count, 1)
    }
    
    
    func testGivenGroupService_WhenDeletingNotExistingGroup_ThenGroupNotDeleted() {
        // Given
        
        let groupManager = FirestoreGroupMock(groups: fetchedGroups)
        let group = Group(groupName: "test5")
        
        // When
        
        groupManager.deleteGroup(group: group)
        
        // Then
        
        XCTAssertEqual(groupManager.groups.count, 2)
        
    }
    
    
}
