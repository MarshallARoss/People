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
    
    private let networkingManager: NetworkingManagerImpl
    
    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared) {
        self.networkingManager = networkingManager
    }
    
    //CLOSURE
    /*
    func fetchUserDetails(for id: Int) {
        isLoading = true
        NetworkingManager.shared.request(.detail(id: id), type: UserDetailResponse.self) { [weak self] res in
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
     */
    
    //ASYNC AWAIT
    @MainActor
    func fetchUserDetails(for id: Int) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            self.userInfo = try await networkingManager.request(session: .shared, .detail(id: id), type: UserDetailResponse.self)
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

