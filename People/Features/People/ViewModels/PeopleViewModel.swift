//
//  PeopleViewModel.swift
//  People
//
//  Created by Marshall  on 8/21/22.
//

import Foundation

final class PeopleViewModel: ObservableObject {
    
    @Published private(set) var users: [User] = []
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var hasError = false
    
    func fetchUsers() {
        NetworkingManager.shared.request("https://reqres.in/api/users", type: UsersResponse.self) { [weak self] res in
            switch res {
            case.success(let response):
                DispatchQueue.main.async {
                    self?.users = response.data
                }
            case.failure(let error):
                print(error)
                self?.error = error as? NetworkingManager.NetworkingError
                self?.hasError = true
            }
        }
    }
    
}
