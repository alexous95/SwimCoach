//
//  FirestorePersonTest.swift
//  SwimCoachTests
//
//  Created by Alexandre Goncalves on 15/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import XCTest
@testable import SwimCoach

class FirestorePersonTest: XCTestCase {

    enum PersonError: Error {
        case empty
    }
    
    var database: [String : [Person]]!
    var error: PersonError!
    var persons1: [Person]!
    var group: Group!
    
    override func setUp() {
        
        error = PersonError.empty
        persons1 = []
        group = Group(groupName: "Arctique")
        
        for index in 0...1 {
            let person1 = Person(personID: "test" + "\(index)", firstName: "testFirst" + "\(index)", lastName: "testLast" + "\(index)", presences: ["test" + "\(index)"])
            
            persons1.append(person1)
        }
        
        database = ["Arctique" : persons1]
    }
    
    
    func testGivenPersonService_WhenFetchingPersonWithError_ThenArrayIsEmpty() {
        // Given
        
        let personManager = FirestorePersonMock(database: database, error: error)
        let expectation = XCTestExpectation(description: "Loading persons")
        
        // When
        
        personManager.fetchPersons(from: group) { (persons, error) in
            // Then
            
            XCTAssertNotNil(error)
            XCTAssertEqual(persons.count, 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGivenPersonService_WhenFetchingPerson_ThenArrayIsEqualDatabase() {
        // Given
        
        let personManager = FirestorePersonMock(database: database)
        let expectation = XCTestExpectation(description: "Loading persons")
        
        // When
        
        personManager.fetchPersons(from: group) { (persons, error) in
            // Then
            
            XCTAssertNil(error)
            XCTAssertEqual(persons.count, self.database["Arctique"]!.count)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGivenPersonService_WhenFetchingPersonFromWrongGroup_ThenArrayIsEmpty() {
        // Given
        
        let personManager = FirestorePersonMock(database: database)
        let expectation = XCTestExpectation(description: "Loading persons")
        
        // When
        
        personManager.fetchPersons(from: Group(groupName: "")) { (persons, error) in
            // Then
            
            XCTAssertEqual(persons.count, 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGivenPersonService_WhenAddingPerson_ThenArrayCountPlus1() {
        // Given
        
        let personManager = FirestorePersonMock(database: database)
        let expectation = XCTestExpectation(description: "Loading persons")
        
        // When
        
        personManager.addPerson(lastName: "Test6", firstName: "Test6", to: group)
        personManager.fetchPersons(from: group) { (persons, error) in
             // Then
            
            XCTAssertNil(error)
            XCTAssertEqual(persons.count, personManager.database[self.group.groupName]!.count)
            expectation.fulfill()
        }
       
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    
    func testGivenPersonService_WhenDeletingPerson_ThenArrayCountMinus1() {
        // Given
        
        let personManager = FirestorePersonMock(database: database)
        let expectation = XCTestExpectation(description: "Loading persons")
        
        // When
        
        personManager.deletePerson(personID: "test1", from: group)
        personManager.fetchPersons(from: group) { (persons, error) in
            // Then
            
            XCTAssertNil(error)
            XCTAssertEqual(persons.count, personManager.database[self.group.groupName]!.count)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGivenPersonService_WhenDeletingNotExistingPerson_ThenArrayCountDoesntChange() {
        // Given
        
        let personManager = FirestorePersonMock(database: database)
        let expectation = XCTestExpectation(description: "Loading persons")
        
        // When
        
        let countBefore = personManager.database[group.groupName]!.count
        personManager.deletePerson(personID: "test12", from: group)
        personManager.fetchPersons(from: group) { (persons, error) in
            // Then
            
            XCTAssertNil(error)
            XCTAssertEqual(persons.count, countBefore)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}
