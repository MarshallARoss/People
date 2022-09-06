//
//  NetworkingEndpointTests.swift
//  PeopleTestsUnitTests
//
//  Created by Marshall  on 9/5/22.
//

import XCTest
@testable import People

class NetworkingEndpointTests: XCTestCase {

    func test_with_people_endpoint_request_is_valid() {
   
        let endpoint = Endpoint.people(page: 1)
        
        XCTAssertEqual(endpoint.host, "reqres.in", "The host should be reqres.in")
        XCTAssertEqual(endpoint.path, "/api/users", "The path should be /api/users")
        XCTAssertEqual(endpoint.methodType, .GET, "Method type should be GET")
        XCTAssertEqual(endpoint.queryItems, ["page" : "1"], "Queryitems should be page 1")
        
        XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users?page=1&delay=4", "Url should be https://reqres.in/api/users?page=1&delay=4")
    }
    
    func test_with_detail_endpoint_request_is_valid() {
        
        let userID = 1
        let endpoint = Endpoint.detail(id: userID)
        
        XCTAssertEqual(endpoint.host, "reqres.in", "The host should be reqres.in")
        XCTAssertEqual(endpoint.path, "/api/users/\(userID)", "The path should be /api/users/\(userID)")
        XCTAssertEqual(endpoint.methodType, .GET, "Method type should be GET")
        XCTAssertNil(endpoint.queryItems, "Queryitems should be nil")
        
        XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users/\(userID)?delay=4")
        
    }
    
    func test_with_create_endpoint_request_is_valid() {
        
        let endpoint = Endpoint.create(submissionData: nil)
        
        XCTAssertEqual(endpoint.host, "reqres.in", "The host should be reqres.in")
        XCTAssertEqual(endpoint.path, "/api/users", "The path should be /api/users")
        XCTAssertEqual(endpoint.methodType, .POST(data: nil), "Method type should be POST")
        XCTAssertNil(endpoint.queryItems, "Queryitems should be nil")
        
        XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users?delay=4")
        
    }
    
}
