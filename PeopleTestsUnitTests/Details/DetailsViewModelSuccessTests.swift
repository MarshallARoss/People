//
//  DetailsViewModelSuccessTests.swift
//  PeopleTestsUnitTests
//
//  Created by Marshall  on 9/8/22.
//

import XCTest
@testable import People

class DetailsViewModelSuccessTests: XCTestCase {

    private var networkingMock: NetworkingManagerImpl!
    private var vm: DetailViewModel!
    
    override func setUp() {
        networkingMock = NetworkingManagerUserDetailsSuccessMock()
        vm = DetailViewModel(networkingManager: networkingMock)
    }
    
    override func tearDown() {
        networkingMock = nil
        vm = nil
    }
    
    func test_with_successful_response_users_details_is_set() async throws {
      
        XCTAssertFalse(vm.isLoading, "The View Model should not be loading")
        
        
        defer {
            XCTAssertFalse(vm.isLoading, "The View Model should not be loading")
        }
        
        await vm.fetchUserDetails(for: 1)
        
        XCTAssertNotNil(vm.userInfo, "User info should not be nil.")
        
        let userDetailsData = try StaticJSONMapper.decode(file: "SingleUser", type: UserDetailResponse.self)
        
        XCTAssertEqual(vm.userInfo, userDetailsData, "Userinfo should be the same")
    }
}
