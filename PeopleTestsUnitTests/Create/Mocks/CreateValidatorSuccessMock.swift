//
//  CreateValidatorSuccessMock.swift
//  PeopleTestsUnitTests
//
//  Created by Marshall  on 9/9/22.
//

import Foundation
@testable import People

struct CreateValidatorSuccessMock: CreateValidatorImpl {
    func validate(_ person: NewPerson) throws {}
}
