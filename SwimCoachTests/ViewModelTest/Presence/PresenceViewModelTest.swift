//
//  PresenceViewModelTest.swift
//  SwimCoachTests
//
//  Created by Alexandre Goncalves on 14/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import XCTest
@testable import SwimCoach

class PresenceViewModelTest: XCTestCase {

    enum PersonError: Error {
        case empty
    }
    
    var group: Group!
    var database: [String : [Person]]!
    var error: PersonError!
    var persons1: [Person]!
    var viewModel: PresenceViewModel!
    var errorViewModel: PresenceViewModel!
    let dateFormatter = DateFormatter()
    
    override func setUp() {
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "FR-fr")
        
        error = .empty
        persons1 = []
        group = Group(groupName: "Arctique")
        
        for index in 0...1 {
            let person1 = Person(personID: "test" + "\(index)", firstName: "testFirst" + "\(index)", lastName: "testLast" + "\(index)", presences: ["test" + "\(index)"])
            
            persons1.append(person1)
        }
        
        database = ["Arctique" : persons1]
        
        viewModel = PresenceViewModel(group: group, networkPerson: FirestorePersonMock(database: database), networkPresence: FirestorePresenceMock(persons: persons1))
        
        errorViewModel = PresenceViewModel(group: group, networkPerson: FirestorePersonMock(database: database, error: error), networkPresence: FirestorePresenceMock(persons: persons1, error: error))
    }
    
    
    func testGivenNil_WhenCreatingViewModelWithParameter_ThenViewModelIsNotNil() {
        // Given
        // When
        
        let viewModel = PresenceViewModel(group: group, networkPerson: FirestorePersonMock(database: database), networkPresence: FirestorePresenceMock(persons: persons1))
        
        // Then
        
        XCTAssertNotNil(viewModel)
        
    }
    
    
    func testGivenViewModel_WhenFetchingPerson_ThenPersonsArrayEqualsDatabaseArray() {
        // Given
        
        var index = 0
        
        // When
        
        viewModel.fetchPerson()
        
        // Then
        
        XCTAssertEqual(viewModel.persons?.count, self.database[viewModel.group.groupName]!.count)
        let personsDatabase = database[group.groupName]
        for person in viewModel.persons! {
            XCTAssertEqual(person.personID, personsDatabase![index].personID)
            XCTAssertEqual(person.firstName, personsDatabase![index].firstName)
            XCTAssertEqual(person.lastName, personsDatabase![index].lastName)
            index += 1
        }
    }
    
    
    func testGivenViewModel_WhenFetchingPersonsWithError_ThenPersonsArrayIsNil() {
        // Given
        // When
        
        errorViewModel.fetchPerson()
        
        // Then
        
        XCTAssertNil(errorViewModel.persons)
        XCTAssertEqual(errorViewModel.error, "error while loading")
    }
    
    
    func testGivenViewModel_WhenAddingPerson_ThenPersonsArrayCountPlus1() {
        // Given
        // When
        
        viewModel.fetchPerson()
        let previous = viewModel.persons!.count
        
        viewModel.addPerson(lastName: "testLast42", firstName: "testFirst42", to: group)
        
        // Then
        
        XCTAssertEqual(viewModel.persons?.count, 3)
        XCTAssertEqual(viewModel.persons?.count, previous + 1)
    }
    
    
    func testGivenViewModel_WhenDeletingPerson_ThenPersonsArrayCountMinus1() {
        // Given
        // When
        
        viewModel.fetchPerson()
        let previous = viewModel.persons!.count
        
        viewModel.deletePerson(personID: "test0", from: group)
        
        // Then
        
        XCTAssertEqual(viewModel.persons?.count, 1)
        XCTAssertEqual(viewModel.persons?.count, previous - 1)
    }
    
    
    func testGivenViewModel_WhenPrintingDate_ThenDateIsConform() {
        // Given
        
        let now = Date()
        let dateString = dateFormatter.string(from: now)
        
        // When
        
        let date = viewModel.printDate()
        
        // Then
        
        XCTAssertEqual(dateString, date)
        
    }
    
    
    func testGivenViewModel_WhenPrintingDateFromSelectedDate_ThenDateIsConform() {
        // Given
        
        let selectedDate = dateFormatter.date(from: "08/04/2020")
        let selectedString = dateFormatter.string(from: selectedDate!)
        
        // When
        
        let date = viewModel.printDate(from: selectedDate!)
        
        // Then
        
        XCTAssertEqual(selectedString, date)
    }
    
    
    func testGivenViewModel_WhenAddingPresenceToPerson_ThenPresenceIsAdded() {
        // Given
        
        var previousCount = 0
        let expectation = XCTestExpectation(description: "Loading presences")
        let now = Date()
        
        viewModel.networkPresence.fetchPresence(personID: "test0", from: group) { (presences, error) in
            previousCount = presences.count
        }
        
        // When
        
        viewModel.addPresence(personID: "test0", from: group)
        viewModel.networkPresence.fetchPresence(personID: "test0", from: group) { (presences, error) in
            // Then
            
            XCTAssertEqual(previousCount + 1, presences.count)
            XCTAssertEqual(presences[1], self.dateFormatter.string(from: now))
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGivenViewModel_WhenAddingPresenceWithSelectedDate_ThenPresenceIsAdded() {
        // Given
        
        var previousCount = 0
        let selectedDate = dateFormatter.date(from: "08/04/2020")
        let expectation = XCTestExpectation(description: "Loading presences")
        viewModel.dateSelected = selectedDate
        
        viewModel.networkPresence.fetchPresence(personID: "test0", from: group) { (presences, error) in
            previousCount = presences.count
        }
        
        // When
        
        viewModel.addPresence(personID: "test0", from: group)
        viewModel.networkPresence.fetchPresence(personID: "test0", from: group) { (presences, error) in
            // Then
            
            XCTAssertEqual(previousCount + 1, presences.count)
            XCTAssertEqual(presences[1], self.dateFormatter.string(from: selectedDate!))
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
   
    
    func testGivenViewModel_WhenCheckingPresence_ThenResultIsTrueIfPresent() {
        // Given
        
        let person = Person(personID: "test42", firstName: "testFirst", lastName: "testLast", presences: [dateFormatter.string(from: Date())])
        
        // When
        
        let result = viewModel.switchState(person: person)
        
        // Then
        
        XCTAssertTrue(result)
    }
    
    
    func testGivenViewModel_WhenCheckingPresenceWithSelectedDate_ThenResultIsTrueIfPresent() {
        // Given
        
        let selectedDate = dateFormatter.date(from: "08/04/2020")
        let person = Person(personID: "test42", firstName: "testFirst", lastName: "testLast", presences: ["08/04/2020"])
        viewModel.dateSelected = selectedDate
        
        // When
        
        let result = viewModel.switchState(person: person)
        
        // Then
        
        XCTAssertTrue(result)
    }
    
    
    func testGivenViewModel_WhenCheckingPresence_ThenResultIsFalseIfNotPresent() {
        // Given
        
        let person = Person(personID: "test42", firstName: "testFirst", lastName: "testLast", presences: ["08/04/2020"])
        
        // When
        
        let result = viewModel.switchState(person: person)
        
        // Then
        
        XCTAssertFalse(result)
    }
    
    
    
    func testGivenViewModel_WhenCheckingPresenceWithSelectedDate_ThenResultIsFalseIfNotPresent() {
        // Given
        
        let person = Person(personID: "test42", firstName: "testFirst", lastName: "testLast", presences: ["08/04/2020"])
        let selectedDate = dateFormatter.date(from: "09/04/2020")
        viewModel.dateSelected = selectedDate
        
        // When
        
        let result = viewModel.switchState(person: person)
        
        // Then
        
        XCTAssertFalse(result)
    }
}
