//
//  DetailViewModel.swift
//  People
//
//  Created by Marshall  on 8/21/22.
//

import Foundation

final class DetailViewModel: ObservableObject {
    
    @Published private(set) var userInfo: UserDetailResponse?
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published private(set) var isLoading: Bool = false
    @Published var hasError = false
    
    func fetchUserDetails(for id: Int) {
        isLoading = true
        NetworkingManager.shared.request("https://reqres.in/api/users/\(id)?delay=3", type: UserDetailResponse.self) { [weak self] res in
            DispatchQueue.main.async {
            defer { self?.isLoading = false }
            switch res {
            case.success(let response):
                    self?.userInfo = response
            case.failure(let error):
                print(error)
                self?.error = error as? NetworkingManager.NetworkingError
                self?.hasError = true
            }
            }
        }

    }
    
}

