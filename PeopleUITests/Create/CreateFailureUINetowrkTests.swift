//
//  CreateFailureUITests.swift
//  PeopleUITests
//
//  Created by Marshall  on 9/16/22.
//

import XCTest

class CreateFailureUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = [
            "-people-networking-success" : "1",
            "-create-networking-success" : "0"
        ]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_alert_is_shown_when_submission_fails() {
        
        let createButton = app.buttons["createButton"]
        XCTAssertTrue(createButton.waitForExistence(timeout: 5), "The create button should be visible on the screen.")
        
        createButton.tap()
        
        let firstNameTextField = app.textFields["firstNameTextField"]
        let lastNameTextField = app.textFields["lastNameTextField"]
        let jobTextField = app.textFields["jobTextField"]
        
        firstNameTextField.tap()
        firstNameTextField.typeText("TestText")
        
        lastNameTextField.tap()
        lastNameTextField.typeText("TestText")
        
        jobTextField.tap()
        jobTextField.typeText("TestText")
        
        
        let submitButton = app.buttons["submitButton"]
        XCTAssertTrue(submitButton.waitForExistence(timeout: 5), "The create button should be visible on the screen")
        
        submitButton.tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 5))
        XCTAssertTrue(alert.staticTexts["URL isn't valid"].exists)
        XCTAssertTrue(alert.buttons["OK"].exists)
        
    }
    
    
    
    
}
