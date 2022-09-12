//
//  CreateValidatorFailureMock.swift
//  PeopleTestsUnitTests
//
//  Created by Marshall  on 9/9/22.
//

#if DEBUG

import Foundation

struct CreateValidatorFailureMock: CreateValidatorImpl {
    func validate(_ person: NewPerson) throws {
        throw CreateValidator.CreateValidatorError.invalidFirstName
    }
}

#endif
