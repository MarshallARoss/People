//
//  NetworkingManager.swift
//  People
//
//  Created by Marshall  on 8/19/22.
//

import Foundation

class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    //Keeps another networking manager from being initiated.
    private init() {}
    
    func request(methodType: MethodType = .GET, _ absoluteURL: String, completion: @escaping (Result<Void, Error>) -> ()) {
        guard let url = URL(string: absoluteURL) else { completion(.failure(NetworkingError.invalidURL))
            return
        }
        
        let request = buildRequest(from: url, methodType: methodType)

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
    
    
    
    func request<T: Codable>(methodType: MethodType = .GET ,_ absoluteURL: String,
                             type: T.Type,
                             completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: absoluteURL) else { completion(.failure(NetworkingError.invalidURL))
            return
        }
       
        let request = buildRequest(from: url, methodType: methodType)
      
        
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

extension NetworkingManager {
    enum MethodType {
        case GET
        case POST(data: Data?)
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
    
    func buildRequest(from Url: URL, methodType: MethodType) -> URLRequest {
        
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
