//
//  PeopleViewModelFailureTests.swift
//  PeopleTestsUnitTests
//
//  Created by Marshall  on 9/7/22.
//

import XCTest
@testable import People

class PeopleViewModelFailureTests: XCTestCase {

    private var networkingMock: NetworkingManagerImpl!
    private var vm: PeopleViewModel!
    
    override func setUp() {
        networkingMock = NetworkingManagerUserResponseFailureMock()
        vm = PeopleViewModel(networkingManager: networkingMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        vm = nil
    }
    
    
    func test_with_unsuccessful_response_error_is_handled() async {
        
        XCTAssertFalse(vm.isLoading, "The view model should not be loading any data.")
        
        defer {
            XCTAssertFalse(vm.isLoading, "The view model should not be loading any data.")
            XCTAssertEqual(vm.viewState, .finished, "View model's view state should be finished.")
        }
        
        await vm.fetchUsers()
        
        XCTAssertTrue(vm.hasError, "vm should have an error")
        XCTAssertNotNil(vm.error, "vm erro should not be nil")
    }
    
    
}
