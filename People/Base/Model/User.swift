//
//  Models.swift
//  People
//
//  Created by Marshall  on 8/13/22.
//

import Foundation

// MARK: - DataClass
struct User: Codable, Equatable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String
    
}

// MARK: - Support
struct Support: Codable, Equatable {
    let url: String
    let text: String
}
