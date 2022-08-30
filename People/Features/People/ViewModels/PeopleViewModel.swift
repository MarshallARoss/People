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
    @Published private(set) var viewState: ViewState?
    @Published var hasError = false
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    var isFetching: Bool {
        viewState == .fetching
    }
    
    private var page = 1
    private var totalPages: Int?
    
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
        refreshView()
        viewState = .loading
        defer { viewState = .finished }
        
        do {
            let response = try await NetworkingManager.shared.request(.people(page: page), type: UsersResponse.self)
            self.users = response.data
            self.totalPages = response.totalPages
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    @MainActor
    func fetchNextSetOfUsers() async {
        
        guard page != totalPages else {return}
        
        viewState = .fetching
        defer { viewState = .finished }
        
        page += 1
        
        do {
            let response = try await NetworkingManager.shared.request(.people(page: page), type: UsersResponse.self)
            self.totalPages = response.totalPages
            self.users += response.data
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
    
    func hasReachedEnd(of user: User) -> Bool {
        users.last?.id == user.id
    }
    
}

extension PeopleViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}

private extension PeopleViewModel {
    func refreshView() {
        if viewState == .finished {
            users.removeAll()
            page = 1
            totalPages = nil
            viewState = nil
        }
    }
}
