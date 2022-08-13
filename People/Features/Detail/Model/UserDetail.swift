//
//  UserDetail.swift
//  People
//
//  Created by Marshall  on 8/13/22.
//

import Foundation

// MARK: - UserDetailResponse
struct UserDetailResponse: Codable {
    let data: User
    let support: Support
}

