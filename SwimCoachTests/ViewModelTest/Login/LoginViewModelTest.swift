//
//  LoginViewModelTest.swift
//  SwimCoachTests
//
//  Created by Alexandre Goncalves on 18/04/2020.
//  Copyright © 2020 Alexandre Goncalves. All rights reserved.
//

import XCTest
import FirebaseAuth
@testable import SwimCoach

class LoginViewModelTest: XCTestCase {

    var viewModel: LoginViewModel!
    
    override func setUp() {
        viewModel = LoginViewModel()
    }
    
    let auth = Auth.auth()
    
    
    func testGivenViewModel_WhenLogingIn_ThenResultIsLoggedIn() {
        
        let expectation = XCTestExpectation(description: "Logging in")
        
        auth.signIn(withEmail: "alexous95@test.com", password: "azertyu") { (result, error) in
            
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    
    func testGivenViewModel_WhenLoggingWithError_ThenAccessIsFalse() {
        // Given
        
        // When
        
        viewModel.authentificate(withEmail: "test", password: "str")
        
        // Then
        
        XCTAssertNotNil(viewModel.access)
        XCTAssertFalse(viewModel.access!)
    }
}
