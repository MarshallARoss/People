//
//  CreateViewModelFailureTests.swift
//  PeopleTestsUnitTests
//
//  Created by Marshall  on 9/9/22.
//

import XCTest
@testable import People

class CreateViewModelFailureTests: XCTestCase {

    private var networkingMock: NetworkingManagerImpl!
    private var validationMock: CreateValidatorImpl!
    private var vm: CreateViewModel!
    
    override func setUp() {
        networkingMock = NetworkingManagerCreateFailureMock()
        validationMock = CreateValidatorSuccessMock()
        vm = CreateViewModel(networkingManager: networkingMock, validator: validationMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        validationMock = nil
        vm = nil
    }
    
    func test_with_unsuccessful_response_submission_state_is_unsuccessful() async throws {
        
        XCTAssertNil(vm.state, "The view model state should be nil")
        defer {
            XCTAssertEqual(vm.state, .unsuccessful, "The vm state should be successful")
        }
        
        await vm.create()
        
        XCTAssertTrue(vm.hasError, "The vm should have an error")
        XCTAssertNotNil(vm.error, "The vm error should not be nil")
        XCTAssertEqual(vm.error, .networking(error: NetworkingManager.NetworkingError.invalidURL), "The vm error should be networking error with invalid url.")
    }
}
