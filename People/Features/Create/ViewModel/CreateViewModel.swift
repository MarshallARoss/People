//
//  CreateViewModel.swift
//  People
//
//  Created by Marshall  on 8/22/22.
//

import Foundation

final class CreateViewModel: ObservableObject {
    
    @Published var person = NewPerson()
    @Published private(set) var state: SubmissionState?
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var hasError = false
    
    
    func create() {
        state = .submitting
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try? encoder.encode(person)
        
        NetworkingManager.shared.request(methodType: .POST(data: data), "https://reqres.in/api/users?delay=3") { [weak self] res in
            switch res {
            case .success:
                self?.state = .successful
                break
            case .failure(let error):
                self?.state = .unsuccessful
                print(error)
                self?.error = error as? NetworkingManager.NetworkingError
                self?.hasError = true
                break
            }
        }
    }
}

extension CreateViewModel {
    enum SubmissionState {
        case unsuccessful
        case successful
        case submitting
    }
}


