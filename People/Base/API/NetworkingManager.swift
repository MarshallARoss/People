//
//  NetworkingManager.swift
//  People
//
//  Created by Marshall  on 8/19/22.
//

import Foundation

protocol NetworkingManagerImpl {
    func request<T: Codable>(session: URLSession,
                             _ endpoint: Endpoint,
                             type: T.Type) async throws -> T
    
    func request(session: URLSession,
                 _ endpoint: Endpoint) async throws
}

class NetworkingManager: NetworkingManagerImpl {
    
    static let shared = NetworkingManager()
    
    //Keeps another networking manager from being initiated.
    private init() {}
    
    //Void Network Request Generic with closure syntax
    /*
     func request(_ endpoint: Endpoint, completion: @escaping (Result<Void, Error>) -> ()) {
     
     guard let url = endpoint.url else { completion(.failure(NetworkingError.invalidURL))
     return
     }
     
     let request = buildRequest(from: url, methodType: endpoint.methodType)
     
     let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
     
     if let error = error {
     completion(.failure(NetworkingError.custom(error: error)))
     return
     }
     
     guard let response = response as? HTTPURLResponse, (200...300) ~= response.statusCode else {
     let statusCode = (response as! HTTPURLResponse).statusCode
     completion(.failure(NetworkingError.invalidStatusCode(statusCode: statusCode)))
     return
     }
     
     completion(.success(()))
     
     }
     
     dataTask.resume()
     }
     */
    
    //Returning Network Request Generic with Closure Syntax
    /*
     func request<T: Codable>(_ endpoint: Endpoint,
     type: T.Type,
     completion: @escaping (Result<T, Error>) -> Void) {
     guard let url = endpoint.url else { completion(.failure(NetworkingError.invalidURL))
     return
     }
     
     let request = buildRequest(from: url, methodType: endpoint.methodType)
     
     
     let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
     
     if let error = error {
     completion(.failure(NetworkingError.custom(error: error)))
     return
     }
     
     guard let response = response as? HTTPURLResponse, (200...300) ~= response.statusCode else {
     let statusCode = (response as! HTTPURLResponse).statusCode
     completion(.failure(NetworkingError.invalidStatusCode(statusCode: statusCode)))
     return
     }
     
     guard let data = data else {
     completion(.failure(NetworkingError.invalidData))
     return
     }
     
     do {
     let decoder = JSONDecoder()
     decoder.keyDecodingStrategy = .convertFromSnakeCase
     let res = try decoder.decode(T.self, from: data)
     completion(.success(res))
     } catch {
     print(error)
     completion(.failure(NetworkingError.failedToDecode(error: error)))
     }
     }
     
     dataTask.resume()
     }
     */
    
    //Returning Network request generic with async await
    func request<T: Codable>(session: URLSession = .shared,
                             _ endpoint: Endpoint,
                             type: T.Type) async throws -> T {
        guard let url = endpoint.url else {
            throw NetworkingError.invalidURL
        }
        
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        
        let (data, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse, (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let res = try decoder.decode(T.self, from: data)
        
        return res
    }
    
    //Void network request generic with async await
    func request(session: URLSession = .shared,
                 _ endpoint: Endpoint) async throws {
        
        guard let url = endpoint.url else {
            throw NetworkingError.invalidURL
        }
        
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        
        let (_, response) = try await session.data(for: request)
        
        guard let response = response as? HTTPURLResponse, (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
    }
}

extension NetworkingManager {
    enum NetworkingError: LocalizedError {
        case invalidURL
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
        
    }
}

extension NetworkingManager.NetworkingError: Equatable {
    static func == (lhs: NetworkingManager.NetworkingError, rhs: NetworkingManager.NetworkingError) -> Bool {
        switch(lhs, rhs) {
        case (.invalidURL, .invalidURL) :
            return true
        case (.custom(let lhsType), .custom(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        case (.invalidStatusCode(let lhsType), .invalidStatusCode(let rhsType)):
            return lhsType == rhsType
        case (.invalidData, .invalidData):
            return true
        case (.failedToDecode(let lhsType), .failedToDecode(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        default: return false
        }
    }
}

extension NetworkingManager.NetworkingError {
    var errorDescription: String? {
        switch self {
            
        case .invalidURL:
            return "URL isn't valid"
        case .custom(error: let error):
            return "Something went wrong \(error.localizedDescription)"
        case .invalidStatusCode:
            return "Status code out of range"
        case .invalidData:
            return "Response data invalid"
        case .failedToDecode:
            return "Failed to decode."
        }
    }
}


private extension NetworkingManager {
    
    func buildRequest(from Url: URL, methodType: Endpoint.MethodType) -> URLRequest {
        
        var request = URLRequest(url: Url)
        
        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        case .POST(let data):
            request.httpMethod = "POST"
            request.httpBody = data
        }
        
        return request
        
    }
    
}
