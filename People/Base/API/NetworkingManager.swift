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
    
    func request<T: Codable>(_ absoluteURL: String,
                             type: T.Type,
                             completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: absoluteURL) else { completion(.failure(NetworkingError.invalidURL))
            return
        }
       
        let request = URLRequest(url: url)
        
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
    enum NetworkingError: Error {
        case invalidURL
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}

