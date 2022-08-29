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
    
    /*
     //CLOSURE SYNTAX
     func fetchUsers() {
     isLoading = true
     NetworkingManager.shared.request(.people, type: UsersResponse.self) { [weak self] res in
     
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
     */
    
    //ASYNC AWAIT
    @MainActor
    func fetchUsers() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await NetworkingManager.shared.request(.people, type: UsersResponse.self)
            self.users = response.data
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
}
