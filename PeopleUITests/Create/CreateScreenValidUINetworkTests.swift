//
//  CreateScreenValidUINetworkTests.swift
//  PeopleUITests
//
//  Created by Marshall  on 9/16/22.
//

import XCTest

class CreateScreenValidUINetworkTests: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = [
            "-people-networking-success" : "1",
            "-create-networking-success" : "1"
        ]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    
    func test_valid_form_is_successful() {
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
        
        XCTAssertTrue(app.navigationBars["People"].waitForExistence(timeout: 5), "Navigation bar title should be 'People'")
        
        
    }
}
