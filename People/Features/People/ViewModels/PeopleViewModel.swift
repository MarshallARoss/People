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
    @Published private(set) var isLoading: Bool = false
    @Published var hasError = false
    
    func fetchUsers() {
        isLoading = true
        NetworkingManager.shared.request("https://reqres.in/api/users?delay=3", type: UsersResponse.self) { [weak self] res in
        
            DispatchQueue.main.async {
            defer { self?.isLoading = false }
            switch res {
            case.success(let response):
                    self?.users = response.data
            case.failure(let error):
                print(error)
                self?.error = error as? NetworkingManager.NetworkingError
                self?.hasError = true
            }
            }
        }
    }
    
}
