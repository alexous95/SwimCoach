//
//  PersonTest.swift
//  SwimCoachTests
//
//  Created by Alexandre Goncalves on 13/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import XCTest
@testable import SwimCoach

class PersonTest: XCTestCase {

    
    func testGivenNil_WhenCreatingPerson_ThenPersonIsNotNil() {
        // Given
        // When
        let person = Person(firstName: "", lastName: "")
        
        // Then
        XCTAssertNotNil(person)
        
    }
    
    
    func testGivenPerson_WhenInitPerson_ThenPersonPropertyEqualInit() {
        // Given
        
        let person: Person
        
        // When
        
        person = Person(firstName: "John", lastName: "Doe")
        
        // Then
        
        XCTAssertEqual(person.firstName, "John")
        XCTAssertEqual(person.lastName, "Doe")
        XCTAssertEqual(person.personID, "")
        XCTAssertEqual(person.presences, [])
        
    }
    
    func testGivenPerson_WhenAccessingDictionnary_ThenValuesEqualProperty() {
        // Given
        
        let person = Person(personID: "test", firstName: "John", lastName: "Doe", presences: ["test1", "test2", "test3"])
        
        // When
        
        let dict = person.dictionary
        
        // Then
        
        XCTAssertEqual(person.personID, dict["personID"] as! String)
        XCTAssertEqual(person.firstName, dict["firstName"] as! String)
        XCTAssertEqual(person.lastName, dict["lastName"] as! String)
        XCTAssertEqual(person.presences, dict["presences"] as! [String])
    }
    
    
    func testGivenDictionnary_WhenCreatingPersonFromDictionnary_ThenPropertyEqualValues() {
        // Given
        
        let dictionnary: [String : Any] = [ "personID" : "test",
                                            "firstName" : "John",
                                            "lastName" : "Doe",
                                            "presences" : ["test1", "test2", "test3"]
        ]
        
        // When
        
        let person = Person(document: dictionnary)
        
        // Then
        
        XCTAssertEqual(person!.personID, "test")
        XCTAssertEqual(person!.firstName, "John")
        XCTAssertEqual(person!.lastName, "Doe")
        XCTAssertEqual(person!.presences, ["test1", "test2", "test3"])
    }
    
    
    func testGivenWrongPersonID_WhenCreatingPersonFromDictionnary_ThenPersonIsNil() {
        // Given
        
        let dictionnary: [String : Any] = [ "personID" : 42,
                                            "firstName" : "John",
                                            "lastName" : "Doe",
                                            "presences" : ["test1", "test2", "test3"]
        ]
        
        // When
        
        let person = Person(document: dictionnary)
        
        // Then
        
        XCTAssertNil(person)
    }
    
    func testGivenWrongFirstName_WhenCreatingPersonFromDictionnary_ThenPersonIsNil() {
        // Given
        
        let dictionnary: [String : Any] = [ "personID" : "test",
                                            "firstName" : 42,
                                            "lastName" : "Doe",
                                            "presences" : ["test1", "test2", "test3"]
        ]
        
        // When
        
        let person = Person(document: dictionnary)
        
        // Then
        
        XCTAssertNil(person)
    }
    
    func testGivenWrongLastName_WhenCreatingPersonFromDictionnary_ThenPersonIsNil() {
        // Given
        
        let dictionnary: [String : Any] = [ "personID" : "test",
                                            "firstName" : "John",
                                            "lastName" : 42,
                                            "presences" : ["test1", "test2", "test3"]
        ]
        
        // When
        
        let person = Person(document: dictionnary)
        
        // Then
        
        XCTAssertNil(person)
    }
    
    func testGivenWrongPresences_WhenCreatingPersonFromDictionnary_ThenPersonIsNil() {
        // Given
        
        let dictionnary: [String : Any] = [ "personID" : "test",
                                            "firstName" : "John",
                                            "lastName" : "Doe",
                                            "presences" : 42
        ]
        
        // When
        
        let person = Person(document: dictionnary)
        
        // Then
        
        XCTAssertNil(person)
    }
}
