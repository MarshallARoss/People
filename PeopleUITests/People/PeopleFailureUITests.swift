//
//  PeopleFailureUITests.swift
//  PeopleUITests
//
//  Created by Marshall  on 9/12/22.
//

import XCTest

class PeopleFailureUITests: XCTestCase {
   
    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-people-networking-success" : "0"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }

    func test_alert_shown_when_screen_fails_to_load() {
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 3), "There should be an alert")
        
        XCTAssertTrue(alert.staticTexts["URL isn't valid"].exists)
        XCTAssertTrue(alert.buttons["Retry"].exists)
    }
    
}
