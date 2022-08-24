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
    @Published var hasError = false
    
    func fetchUserDetails(for id: Int) {
        NetworkingManager.shared.request("https://reqres.in/api/users/\(id)", type: UserDetailResponse.self) { [weak self] res in
            switch res {
            case.success(let response):
                DispatchQueue.main.async {
                    self?.userInfo = response
                }
            case.failure(let error):
                print(error)
                self?.error = error as? NetworkingManager.NetworkingError
                self?.hasError = true
            }
        }

    }
    
}
