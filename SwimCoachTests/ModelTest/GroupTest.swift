//
//  GroupTest.swift
//  SwimCoachTests
//
//  Created by Alexandre Goncalves on 13/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import XCTest
@testable import SwimCoach

class GroupTest: XCTestCase {

    
    func testGivenNil_WhenCreatingGroup_ThenGroupIsNotNil() {
        
        // Given
        // When
        
        let group = Group(groupName: "")
        
        // Then
        
        XCTAssertNotNil(group)
    }
    
    
    func testGivenGroup_WhenInitPerson_ThenGroupPropertyEqualsInit() {
        // Given
        
        let group: Group
        
        // When
        
        group = Group(groupName: "test")
        
        // Then
        
        XCTAssertEqual(group.groupName, "test")
    }
    
    
    func testGivenPerson_WhenAccessingDictionnary_ThenValuesEqualProperty() {
        // Given
        
        let group = Group(groupName: "test")
        
        // When
        
        let dict = group.dictionnary
        
        // Then
        
        XCTAssertEqual(group.groupName, dict["groupName"] as! String)
    }
    
    func testGivenDictionnary_WhenCreatingGroupFromDictionnary_ThenPropertyEqualValues() {
        // Given
        
        let dictionnary: [String : Any] = ["groupName" : "test"]
        
        // When
        
        let group = Group(document: dictionnary)
        
        // Then
        
        XCTAssertNotNil(group)
        XCTAssertEqual(group!.groupName, "test")
    }
    
    func testGivenWrongGroupName_WhenCreatingGroupFromDictionnary_ThenGroupIsNil() {
        // Given
        
        let dictionnary: [String : Any] = ["groupName" : 42]
        
        // When
        
        let group = Group(document: dictionnary)
        
        // Then
        
        XCTAssertNil(group)
    }

}
