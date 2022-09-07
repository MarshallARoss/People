//
//  NetworkingManagerUserResponseSuccessMock.swift
//  PeopleTestsUnitTests
//
//  Created by Marshall  on 9/7/22.
//

import Foundation
@testable import People

class NetworkingManagerUserResponseSuccessMock: NetworkingManagerImpl {
   
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return try StaticJSONMapper.decode(file: "Users", type: UsersResponse.self) as! T
    }
    
    func request(session: URLSession, _ endpoint: Endpoint) async throws {
        
    }
    
    
}
