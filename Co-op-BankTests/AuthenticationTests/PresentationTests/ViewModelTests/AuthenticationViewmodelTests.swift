//
//  AuthenticationViewmodelTests.swift
//  Co-op-BankTests
//
//  Created by Martin Wainaina on 15/05/2024.
//

import Foundation
@testable import Co_op_Bank
import XCTest

class AuthenticationViewmodelTests: XCTestCase {
    
    var viewModel: AuthenticationViewmodel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = AuthenticationViewmodel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }
    
    func testInitialState() throws {
        XCTAssertEqual(viewModel.state, FetchState.good, "Assert that initial FetchState state is good")
        XCTAssertEqual(viewModel.username, "", "Assert that initially username is empty")
        XCTAssertEqual(viewModel.password, "", "Assert that initially password is empty")
        XCTAssertFalse(viewModel.isPasswordVisible, "Assert that initially password is inivisible")
        XCTAssertFalse(viewModel.isAuthenticated, "Assert that initially isAuthenticated is false")
        XCTAssertNil(viewModel.user, "Assert that initially user is nil ")
        XCTAssertNil(viewModel.toast, "Assert that initially toast is nil")
        XCTAssertEqual(viewModel.usernameError, "", "Assert that initially usernameError is empty ")
        XCTAssertEqual(viewModel.passwordError, "", "Assert that initially passwordError is empty")
    }
    
    func testValidateUsernameWhenEmpty() throws {
          viewModel.username = ""
          let error = viewModel.valdateUsername()
          XCTAssertEqual(error, "Username can't be empty", "Assert that Username correct Username error is displayed")
          XCTAssertEqual(viewModel.usernameError, "Username can't be empty", "Assert that Username correct Username error is displayed")
      }
    
    func testValidateUsernameWhenNotEmpty() throws {
            viewModel.username = "user"
            let error = viewModel.valdateUsername()
            XCTAssertEqual(error, "", "Assert that when user types something, no error message is displayed")
            XCTAssertEqual(viewModel.usernameError, "", "Assert that when user types something, no error message is displayed")
        }
    
    func testValidatePasswordWhenEmpty() throws {
           viewModel.password = ""
           let error = viewModel.valdatePassword()
           XCTAssertEqual(error, "Password can't be empty", "Assert that password is correct password error is displayed")
           XCTAssertEqual(viewModel.passwordError, "Password can't be empty", "Assert that password is correct password error is displayed")
       }
    
    func testValidatePasswordWwhenNotEmpty() throws {
            viewModel.password = "password"
            let error = viewModel.valdatePassword()
            XCTAssertEqual(error, "", "Assert that when user types something, no error message is displayed")
            XCTAssertEqual(viewModel.passwordError, "", "Assert that when user types something, no error message is displayed")
        }
    
    func testAuthenticateUserWithEmptyFields() async throws {
            viewModel.username = ""
            viewModel.password = ""
            await viewModel.authenticateUser()
            XCTAssertEqual(viewModel.usernameError, "Username can't be empty")
            XCTAssertEqual(viewModel.passwordError, "Password can't be empty")
            XCTAssertEqual(viewModel.state, FetchState.good)
        }
    
    func testAuthenticateUserWithEmptyUsername() async throws {
           viewModel.username = ""
           viewModel.password = "password"
           await viewModel.authenticateUser()
           XCTAssertEqual(viewModel.usernameError, "Username can't be empty")
           XCTAssertEqual(viewModel.passwordError, "")
           XCTAssertEqual(viewModel.state, FetchState.good)
       }
    

    func testAuthenticateUserWithEmptyPassword() async throws {
           viewModel.username = "user"
           viewModel.password = ""
           await viewModel.authenticateUser()
           XCTAssertEqual(viewModel.usernameError, "")
           XCTAssertEqual(viewModel.passwordError, "Password can't be empty")
           XCTAssertEqual(viewModel.state, FetchState.good)
       }
}


