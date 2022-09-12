//
//  NetworkingManagerUserResponseFailureMock.swift
//  PeopleTestsUnitTests
//
//  Created by Marshall  on 9/7/22.
//

#if DEBUG

import Foundation

class NetworkingManagerUserResponseFailureMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        throw NetworkingManager.NetworkingError.invalidURL
    }
    
    func request(session: URLSession, _ endpoint: Endpoint) async throws {
    }
    
}

#endif
