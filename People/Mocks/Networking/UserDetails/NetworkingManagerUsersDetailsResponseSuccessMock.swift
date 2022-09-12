//
//  NetworkingManagerUsersDetailsResponseSuccessMock.swift
//  PeopleTestsUnitTests
//
//  Created by Marshall  on 9/8/22.
//

#if DEBUG

import Foundation

class NetworkingManagerUserDetailsSuccessMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return try StaticJSONMapper.decode(file: "SingleUser", type: UserDetailResponse.self) as! T
    }
    
    func request(session: URLSession, _ endpoint: Endpoint) async throws {
        
    }
}

#endif
