//
//  PreviewProvider.swift
//  People
//
//  Created by Marshall  on 8/15/22.
//

import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        DeveloperPreview.instance
    }
}


class DeveloperPreview {
    static let instance = DeveloperPreview()
    
    private init() {}
    
    var previewUser: User {
        let users = try! StaticJSONMapper.decode(file: "Users", type: UsersResponse.self)
        
        return users.data.first!
    }
    
    var previewUsers: [User] {
        let users = try! StaticJSONMapper.decode(file: "Users", type: UsersResponse.self)
        
        return users.data
    }
    
    var previewUserDetail: UserDetailResponse {
        let userDetail = try! StaticJSONMapper.decode(file: "SingleUser", type: UserDetailResponse.self)
        
        return userDetail
    }
    
}
