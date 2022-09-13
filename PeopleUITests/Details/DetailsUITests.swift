//
//  DetailsUITests.swift
//  PeopleUITests
//
//  Created by Marshall  on 9/13/22.
//

import XCTest

class DetailsUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = [
            "-people-networking-success" : "1",
            "-details-networking-success" : "1"
        ]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    
}
