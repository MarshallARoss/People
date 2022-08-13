//
//  UsersResponse.swift
//  People
//
//  Created by Marshall  on 8/13/22.
//

import Foundation

// MARK: - UsersResponse
struct UsersResponse: Codable {
    let page, perPage, total, totalPages: Int
    let data: [User]
    let support: Support
}
