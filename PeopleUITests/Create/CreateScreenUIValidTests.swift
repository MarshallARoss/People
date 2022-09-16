//
//  CreateScreenUIValidTests.swift
//  PeopleUITests
//
//  Created by Marshall  on 9/15/22.
//

import XCTest

class CreateScreenUIValidTests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = [
            "-people-networking-success" : "1"
        ]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_when_create_is_tapped_create_view_is_presented() {
        
        let createButton = app.buttons["createButton"]
        XCTAssertTrue(createButton.waitForExistence(timeout: 5), "The create button should be visible on the screen.")
        
        createButton.tap()
        
        XCTAssertTrue(app.navigationBars["Create"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.buttons["submitButton"].exists)
        XCTAssertTrue(app.buttons["dismissButton"].exists)
        XCTAssertTrue(app.textFields["firstNameTextField"].exists)
        XCTAssertTrue(app.textFields["lastNameTextField"].exists)
        XCTAssertTrue(app.textFields["jobTextField"].exists)
        
        
    }
    
    
    func test_when_done_button_tapped_view_is_dismissed() {
     
        let createButton = app.buttons["createButton"]
        XCTAssertTrue(createButton.waitForExistence(timeout: 5), "The create button should be visible on the screen.")
       
        createButton.tap()
        
        let dismissButton = app.buttons["dismissButton"]
        XCTAssertTrue(dismissButton.exists)
        
        XCTAssertTrue(app.navigationBars["People"].waitForExistence(timeout: 5), "Navigation Bar Should Be People")
    }
    
    
    
    
}
