//
//  CreateScreenFormValidationTests.swift
//  PeopleUITests
//
//  Created by Marshall  on 9/16/22.
//

import XCTest

class CreateScreenFormValidationTests: XCTestCase {
 
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
    
    func test_when_all_form_fields_are_empty_first_name_error_is_shown() {
       
        let createButton = app.buttons["createButton"]
        XCTAssertTrue(createButton.waitForExistence(timeout: 5), "The create button should be visible on the screen.")
        
        createButton.tap()
        
        let submitButton = app.buttons["submitButton"]
        XCTAssertTrue(submitButton.waitForExistence(timeout: 5), "The submit button should be visible on screen")
        
        submitButton.tap()
        
        let alert = app.alerts.firstMatch
        let alertButton = alert.buttons.firstMatch
        
        XCTAssertTrue(alert.waitForExistence(timeout: 5), "An alert should be presented")
        XCTAssertTrue(alert.staticTexts["First name can't be empty"].exists)
        XCTAssertEqual(alertButton.label, "OK")

        alertButton.tap()
        
        XCTAssertTrue(app.staticTexts["First name can't be empty"].exists)
        
        XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen.")
        
    }
    
    func test_when_first_name_form_field_is_empty_first_name_error_is_shown() {
        
        let createButton = app.buttons["createButton"]
        XCTAssertTrue(createButton.waitForExistence(timeout: 5), "The create button should be visible on the screen.")
        
        createButton.tap()
        
        let lastNameTextField = app.textFields["lastNameTextField"]
        let jobTextField = app.textFields["jobTextField"]
        
        lastNameTextField.tap()
        lastNameTextField.typeText("Gloop")
        
        jobTextField.tap()
        jobTextField.typeText("Candyman")
        
        let submitButton = app.buttons["submitButton"]
        XCTAssertTrue(submitButton.waitForExistence(timeout: 5), "The submit button should be visible on screen")
        
        submitButton.tap()
        
        let alert = app.alerts.firstMatch
        let alertButton = alert.buttons.firstMatch
        
        XCTAssertTrue(alert.waitForExistence(timeout: 5), "An alert should be presented")
        XCTAssertTrue(alert.staticTexts["First name can't be empty"].exists)
        XCTAssertEqual(alertButton.label, "OK")
        
        alertButton.tap()
        
        XCTAssertTrue(app.staticTexts["First name can't be empty"].exists)
        
        XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen.")
        
    }
    
    func test_when_last_name_form_field_is_empty_first_name_error_is_shown() {
        
        let createButton = app.buttons["createButton"]
        XCTAssertTrue(createButton.waitForExistence(timeout: 5), "The create button should be visible on the screen.")
        
        createButton.tap()
        
        let firstNameTextField = app.textFields["firstNameTextField"]
        let jobTextField = app.textFields["jobTextField"]
        
        firstNameTextField.tap()
        firstNameTextField.typeText("Augustus")
        
        jobTextField.tap()
        jobTextField.typeText("Candyman")
        
        let submitButton = app.buttons["submitButton"]
        XCTAssertTrue(submitButton.waitForExistence(timeout: 5), "The submit button should be visible on screen")
        
        submitButton.tap()
        
        let alert = app.alerts.firstMatch
        let alertButton = alert.buttons.firstMatch
        
        XCTAssertTrue(alert.waitForExistence(timeout: 5), "An alert should be presented")
        XCTAssertTrue(alert.staticTexts["Last name can't be empty"].exists)
        XCTAssertEqual(alertButton.label, "OK")
        
        alertButton.tap()
        
        XCTAssertTrue(app.staticTexts["Last name can't be empty"].exists)
        
        XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen.")
        
    }
    
    func test_when_job_form_field_is_empty_first_name_error_is_shown() {
        
        let createButton = app.buttons["createButton"]
        XCTAssertTrue(createButton.waitForExistence(timeout: 5), "The create button should be visible on the screen.")
        
        createButton.tap()
        
        let firstNameTextField = app.textFields["firstNameTextField"]
        let lastNameTextField = app.textFields["lastNameTextField"]
        
        firstNameTextField.tap()
        firstNameTextField.typeText("Augustus")
        
        lastNameTextField.tap()
        lastNameTextField.typeText("Gloop")
        
        let submitButton = app.buttons["submitButton"]
        XCTAssertTrue(submitButton.waitForExistence(timeout: 5), "The submit button should be visible on screen")
        
        submitButton.tap()
        
        let alert = app.alerts.firstMatch
        let alertButton = alert.buttons.firstMatch
        
        XCTAssertTrue(alert.waitForExistence(timeout: 5), "An alert should be presented")
        XCTAssertTrue(alert.staticTexts["Job can't be empty"].exists)
        XCTAssertEqual(alertButton.label, "OK")
        
        alertButton.tap()
        
        XCTAssertTrue(app.staticTexts["Job can't be empty"].exists)
        
        XCTAssertEqual(app.alerts.count, 0, "There should be no alerts on the screen.")
        
    }
    
    
}
