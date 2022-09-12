//
//  NetworkingManagerCreateFailureMock.swift
//  PeopleTestsUnitTests
//
//  Created by Marshall  on 9/9/22.
//

#if DEBUG

import Foundation

class NetworkingManagerCreateFailureMock: NetworkingManagerImpl {
    
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return Data() as! T
    }
    
    func request(session: URLSession, _ endpoint: Endpoint) async throws {
        throw NetworkingManager.NetworkingError.invalidURL
    }
}

#endif
