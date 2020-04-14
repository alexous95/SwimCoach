//
//  FirestorePresenceTest.swift
//  SwimCoachTests
//
//  Created by Alexandre Goncalves on 14/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import XCTest
@testable import SwimCoach

class FirestorePresenceTest: XCTestCase {
    
    enum PresenceError: Error {
        case empty
    }
    
    var database: [String : [Person]]!
    var error: PresenceError!
    var persons1: [Person]!
    
    override func setUp() {
        
        error = PresenceError.empty
        persons1 = []
        var persons2: [Person] = []
        
        for index in 0...1 {
            let person1 = Person(personID: "test" + "\(index)", firstName: "testFirst" + "\(index)", lastName: "testLast" + "\(index)", presences: ["test" + "\(index)"])
            let person2 = Person(personID: "\(index + 2)", firstName: "testFirst" + "\(index + 2)", lastName: "testLast" + "\(index + 2)", presences: ["test" + "\(index + 2)"])
            
            persons1.append(person1)
            persons2.append(person2)
        }
        
        database = ["Arctique" : persons1, "Competition" : persons2]
    }
    
    
    
    func testGivenPresenceService_WhenFetchingPresencesWithError_ThenArrayIsEmpty() {
        // Given
        
        let presenceManager = FirestorePresenceMock(persons: [], error: error)
        let expectation = XCTestExpectation(description: "Loading presences")
        
        // When
        
        presenceManager.fetchPresence(personID: "test", from: Group(groupName: "test")) { (presences, error) in
            // Then
            
            XCTAssertNotNil(error)
            XCTAssertEqual(presences.count, 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGivenPresenceService_WhenFetchingPresence_ThenPresenceArrayIsNotEmpty() {
        // Given
        
        let presenceManager = FirestorePresenceMock(persons: persons1)
        let expectation = XCTestExpectation(description: "Loading presences")
        
        // When
        
        presenceManager.fetchPresence(personID: "test1", from: Group(groupName: "test")) { (presences, error) in
            // Then
            
            XCTAssertNil(error)
            XCTAssertEqual(presences.count, 1)
            XCTAssertEqual(presences[0], "test1")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGivenPresenceService_WhenAddingPresence_ThenPresenceCountPlus1() {
        // Given
        
        let presenceManager = FirestorePresenceMock(persons: persons1)
        let expectation = XCTestExpectation(description: "Loading presences")
        
        // When
        
        presenceManager.addPresence(personID: "test1", from: Group(groupName: "test"), stringDate: "dateTest")
        presenceManager.fetchPresence(personID: "test1", from: Group(groupName: "test")) { (presences, error) in
            // Then
            
            XCTAssertEqual(presences.count, 2)
            XCTAssertEqual(presences[1], "dateTest")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}
