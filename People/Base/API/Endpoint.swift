//
//  Endpoint.swift
//  People
//
//  Created by Marshall  on 8/26/22.
//

import Foundation

enum Endpoint {
    case people(page: Int)
    case detail(id: Int)
    case create(submissionData: Data?)
}

extension Endpoint {
    enum MethodType: Equatable {
        case GET
        case POST(data: Data?)
    }
}

extension Endpoint {
    var host: String { "reqres.in" }
    var path: String{
        switch self {
        case .people, .create:
            return "/api/users"
        case .detail(let id):
            return "/api/users/\(id)"
        }
    }
    
    var methodType: MethodType {
        switch self {
        case .people, .detail:
            return .GET
        case .create(let data):
            return .POST(data: data)
        }
    }
    
    var queryItems: [String : String]? {
        switch self {
        case .people(let page):
             return ["page":"\(page)"]
        default:
            return nil
        }
    }
}

extension Endpoint {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        var requestQueryItems: [URLQueryItem] = []
        
        queryItems?.forEach { item in
            requestQueryItems.append(URLQueryItem(name: item.key, value: item.value))
        }
//
//        var requestQueryItems = queryItems?.compactMap { item in
//            URLQueryItem(name: item.key, value: item.value)
//        }
        
        #if DEBUG
        requestQueryItems.append(URLQueryItem(name: "delay", value: "4"))
        #endif

        urlComponents.queryItems = requestQueryItems
        return urlComponents.url
    }
}
