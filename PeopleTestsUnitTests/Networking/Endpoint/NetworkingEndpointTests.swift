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
   
        let peopleEndpoint = Endpoint.people(page: 1)
        
        XCTAssertEqual(peopleEndpoint.host, "reqres.in", "The host should be reqres.in")
        XCTAssertEqual(peopleEndpoint.path, "/api/users", "The path should be /api/users")
        XCTAssertEqual(peopleEndpoint.methodType, .GET, "Method type should be GET")
        XCTAssertEqual(peopleEndpoint.queryItems, ["page" : "1"], "Queryitems should be page 1")
        
        XCTAssertEqual(peopleEndpoint.url?.absoluteString, "https://reqres.in/api/users?page=1&delay=4", "Url should be https://reqres.in/api/users?page=1&delay=4")
    }
    
    func test_with_detail_endpoint_request_is_valid() {
        
    }
    
    func test_with_create_endpoint_request_is_valid() {
        
    }
    
}
