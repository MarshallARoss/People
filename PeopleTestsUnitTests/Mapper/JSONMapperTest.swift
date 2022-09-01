//
//  JSONMapperTest.swift
//  PeopleTestsUnitTests
//
//  Created by Marshall  on 9/1/22.
//

import Foundation
import XCTest
@testable import People

class JSONMapperTests: XCTestCase {
 
    func test_with_valid_jason_soccessfully_decodes() {
        XCTAssertNoThrow(try StaticJSONMapper.decode(file: "Users", type: UsersResponse.self), "Mapper should NOT throw an error.")
        
        let userResponse = try? StaticJSONMapper.decode(file: "Users", type: UsersResponse.self)
        XCTAssertNotNil(userResponse, "User resonse should NOT be nil.")
        
        XCTAssertEqual(userResponse?.page, 1, "Page number should be 1")
        XCTAssertEqual(userResponse?.perPage, 6, "Page number should be 6")
        XCTAssertEqual(userResponse?.total, 12, "Total should be 12")
        XCTAssertEqual(userResponse?.totalPages, 2, "Total pages should be 2")
        
        XCTAssertEqual(userResponse?.data.count, 6, "Total items should be 6.")
       
        XCTAssertEqual(userResponse?.data[0].id, 1, "ID should be 1")
        XCTAssertEqual(userResponse?.data[0].email, "george.bluth@reqres.in", "The email should be george.bluth@reqres.in")
        XCTAssertEqual(userResponse?.data[0].firstName, "George", "First name should be George")
        XCTAssertEqual(userResponse?.data[0].lastName, "Bluth", "Last name should be Bluth")
        XCTAssertEqual(userResponse?.data[0].avatar, "https://reqres.in/img/faces/1-image.jpg", "Avatarimage url should be https://reqres.in/img/faces/1-image.jpg")
    }
    
    func test_with_missing_file_error_thrown() {
        XCTAssertThrowsError(try StaticJSONMapper.decode(file: "", type: UsersResponse.self), "An error should be thrown")
        do {
            _ = try StaticJSONMapper.decode(file: "", type: UsersResponse.self)
        } catch {
            guard let mappingError = error as? StaticJSONMapper.MappingError else {
                XCTFail("this is the wrong type of error for missing files")
                return
            }
            XCTAssertEqual(mappingError, StaticJSONMapper.MappingError.failedToGetContents, "This should be a failed to get contents error")
        }
    }
    
    func test_with_invalid_file_error_thrown() {
        XCTAssertThrowsError(try StaticJSONMapper.decode(file: "asdffks", type: UsersResponse.self), "An error should be thrown")
      
        do {
            _ = try StaticJSONMapper.decode(file: "fdskfj", type: UsersResponse.self)
        } catch {
            guard let mappingError = error as? StaticJSONMapper.MappingError else {
                XCTFail("this is the wrong type of error for missing files")
                return
            }
            XCTAssertEqual(mappingError, StaticJSONMapper.MappingError.failedToGetContents, "This should be a failed to get contents error")
        }
    }
    
    func test_with_invalid_json_error_thrown() {
        XCTAssertThrowsError(try StaticJSONMapper.decode(file: "Users", type: UserDetailResponse.self), "An error should be thrown")
        
        do {
            _ = try StaticJSONMapper.decode(file: "Users", type: UserDetailResponse.self)
        } catch {
            if error is StaticJSONMapper.MappingError {
                XCTFail("Got the wrong error, expecting a system decoding error.")
            }
        }
    }
}
