//
//  CreateValidatorSuccessMock.swift
//  PeopleTestsUnitTests
//
//  Created by Marshall  on 9/9/22.
//

#if DEBUG


import Foundation

struct CreateValidatorSuccessMock: CreateValidatorImpl {
    func validate(_ person: NewPerson) throws {}
}

#endif
