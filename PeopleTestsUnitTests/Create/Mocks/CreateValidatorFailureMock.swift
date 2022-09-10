//
//  CreateValidatorFailureMock.swift
//  PeopleTestsUnitTests
//
//  Created by Marshall  on 9/9/22.
//

import Foundation
@testable import People

struct CreateValidatorFailureMock: CreateValidatorImpl {
    func validate(_ person: NewPerson) throws {
        throw CreateValidator.CreateValidatorError.invalidFirstName
    }
}
