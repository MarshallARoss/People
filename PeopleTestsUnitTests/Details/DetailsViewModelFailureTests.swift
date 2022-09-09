//
//  DetailsViewModelFailureTests.swift
//  PeopleTestsUnitTests
//
//  Created by Marshall  on 9/8/22.
//

import XCTest
@testable import People

class DetailsViewModelFailureTests: XCTestCase {
    
    private var networkingMock: NetworkingManagerImpl!
    private var vm: DetailViewModel!
    
    override func setUp() {
        networkingMock = NetworkingManagerUserResponseFailureMock()
        vm = DetailViewModel(networkingManager: networkingMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        vm = nil
    }
    
    func test_with_unsuccessful_response_users_details_is_set() async throws {
        
        XCTAssertFalse(vm.isLoading, "The View Model should not be loading")
        
        
        defer {
            XCTAssertFalse(vm.isLoading, "The View Model should not be loading")
        }
        
        await vm.fetchUserDetails(for: 1)
        
        XCTAssertTrue(vm.hasError, "The viewmodel error should be true")
        
        XCTAssertNotNil(vm.error, "The viewmodel error should not be nil")
        
        
    }
}
