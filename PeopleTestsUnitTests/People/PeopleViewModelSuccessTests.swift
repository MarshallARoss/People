//
//  PeopleViewModelSuccessTests.swift
//  PeopleTestsUnitTests
//
//  Created by Marshall  on 9/7/22.
//

import XCTest
@testable import People

class PeopleViewModelSuccessTests: XCTestCase {

    private var networkingMock: NetworkingManagerImpl!
    private var vm: PeopleViewModel!
    
    override func setUp() {
        networkingMock = NetworkingManagerUserResponseSuccessMock()
        vm = PeopleViewModel(networkingManager: networkingMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        vm = nil
    }
    
    func test_with_successful_response_users_array_is_set() async {
        
        XCTAssertFalse(vm.isLoading, "The view model should not be loading any data.")
        defer {
            XCTAssertFalse(vm.isLoading, "The view model should not be loading any data.")
            XCTAssertEqual(vm.viewState, .finished, "View model's view state should be finished.")
        }
        await vm.fetchUsers()
        XCTAssertEqual(vm.users.count, 6, "There should be 6 users")
        
    }
    
    func test_with_successful_paginated_response_users_array_is_set() async throws {
        
        XCTAssertFalse(vm.isLoading, "The view model should not be loading any data.")
        
        defer {
            XCTAssertFalse(vm.isFetching, "The view model should not be loading any data.")
            XCTAssertEqual(vm.viewState, .finished, "View model's view state should be finished.")
        }
        
        await vm.fetchUsers()
        
        XCTAssertEqual(vm.users.count, 6, "There should be 6 users.")
        
        await vm.fetchNextSetOfUsers()
        
        XCTAssertEqual(vm.users.count, 12, "There should be 12 users")
        XCTAssertEqual(vm.page, 2, "Page should be 2")
        

    }
    
    func test_with_reset_called_values_is_reser() async throws {
         
        
        defer {
            XCTAssertEqual(vm.users.count, 6, "There should be 6 users within our data array")
            XCTAssertEqual(vm.page, 1, "The page should be 1")
            XCTAssertEqual(vm.totalPages, 2, "Total pages should be two.")
            XCTAssertEqual(vm.viewState, .finished, "View state should be finished")
            XCTAssertFalse(vm.isLoading, "The vm shouldn't be loading.")
        }
        
        await vm.fetchUsers()
        
        XCTAssertEqual(vm.users.count, 6, "There should be 6 users within our data array")
        
        await vm.fetchNextSetOfUsers()
        
        XCTAssertEqual(vm.users.count, 12, "There should be 12 users without our data array.")
        
        XCTAssertEqual(vm.page, 2, "The page should be 2")
        
        await vm.fetchUsers()
    }
    
    func test_with_user_func_returns_true() async {
        
        await vm.fetchUsers()
        
        let userData = try! StaticJSONMapper.decode(file: "Users", type: UsersResponse.self)
        let hasReachedEnd = vm.hasReachedEnd(of: userData.data.last!)
        
        XCTAssertTrue(hasReachedEnd, "The last user should match.")
    }

}
