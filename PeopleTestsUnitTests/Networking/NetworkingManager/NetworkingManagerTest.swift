//
//  NetworkingManagerTest.swift
//  PeopleTestsUnitTests
//
//  Created by Marshall  on 9/6/22.
//

import XCTest
@testable import People

class NetworkingManagerTest: XCTestCase {

    private var session: URLSession!
    private var url: URL!
    
    override func setUp() {
        url = URL(string: "https://reqres.in/users")
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        session = URLSession(configuration: configuration)
    }
    
    override func tearDown() {
            session = nil
            url = nil
    }
    
    func test_with_successful_response_response_is_valid() async throws {
        
        guard let path = Bundle.main.path(forResource: "Users", ofType: "json"), let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get the static users file")
            return
        }
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)
            
            return (response!, data)
        }
        
        let res = try await NetworkingManager.shared.request(session: session, .people(page: 1), type: UsersResponse.self)
        
        let staticJSON = try StaticJSONMapper.decode(file: "Users", type: UsersResponse.self)
        
        XCTAssertEqual(res, staticJSON, "The returned response should be decoded properly.")
    }
    
    func test_with_successful_response_void_is_valid() async throws {
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)
            
            return (response!, nil)
        }
        
        _ = try await NetworkingManager.shared.request(session: session, .people(page: 1))
    }
    
    func test_with_unsuccessful_response_code_in_invalid_range_is_invalid() async {
        
        let statusCode = 400
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: statusCode,
                                           httpVersion: nil,
                                           headerFields: nil)
            
            return (response!, nil)
        }
        
        do {
            _ = try await NetworkingManager.shared.request(session: session, .people(page: 1), type: UsersResponse.self)
            
        } catch {
            guard let netError = error as? NetworkingManager.NetworkingError else {
                XCTFail("Got the wrong type of error. Expecting NetworkingManager NetworkingError")
                return
            }
            
            XCTAssertEqual(netError, NetworkingManager.NetworkingError.invalidStatusCode(statusCode: statusCode), "Error should be networking error with code of \(statusCode)")
        }
    }
    
    func test_with_unsuccessful_response_code_void_in_invalid_range_is_invalid() async {
        
        let statusCode = 400
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: statusCode,
                                           httpVersion: nil,
                                           headerFields: nil)
            
            return (response!, nil)
        }
        
        do {
            
            _ = try await NetworkingManager.shared.request(session: session, .people(page: 1))
            
        } catch {
            
            guard let netError = error as? NetworkingManager.NetworkingError else {
                XCTFail("Got the wrong type of error. Expecting NetworkingManager NetworkingError")
                return
            }
            
            XCTAssertEqual(netError, NetworkingManager.NetworkingError.invalidStatusCode(statusCode: statusCode), "Error should be networking error with code of \(statusCode)")
            
        }
    }
    
    func test_with_successful_response_with_invalid_json_is_invalid() async {
        guard let path = Bundle.main.path(forResource: "Users", ofType: "json"), let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get the status users file")
            return
        }
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)
            return (response!, data)
        }
        
        do {
            _ = try await NetworkingManager.shared.request(session: session, .people(page: 1), type: UserDetailResponse.self)
        } catch {
            if error is NetworkingManager.NetworkingError {
                XCTFail("The error should be a system decoding error")
            }
        }
    }
}
