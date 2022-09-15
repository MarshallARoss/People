//
//  DetailsFailureUITests.swift
//  PeopleUITests
//
//  Created by Marshall  on 9/14/22.
//


import XCTest
import SwiftUI

class DetailsFailureUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = [
            "-people-networking-success" : "1",
            "-details-networking-success" : "0"
        ]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_alert_shown_when_screen_fails_to_load() {
        
        let grid = app.otherElements["peopleGrid"]
        
        XCTAssertTrue(grid.waitForExistence(timeout: 5), "The grid should exist")
        
        let predicate = NSPredicate(format: "identifier CONTAINS 'item_'")
        let gridItems = grid.buttons.containing(predicate)
        
        gridItems.firstMatch.tap()
        
        let alert = app.alerts.firstMatch
      
        XCTAssertTrue(alert.waitForExistence(timeout: 3), "There should be an alert")
        
        XCTAssertTrue(alert.staticTexts["URL isn't valid"].exists)
        XCTAssertTrue(alert.buttons["OK"].exists)
        
        XCTAssertTrue(app.staticTexts["0"].exists)
        XCTAssertTrue(app.staticTexts["First Name"].exists)
        XCTAssertTrue(app.staticTexts["Last Name"].exists)
        XCTAssertTrue(app.staticTexts["Email"].exists)
        
        let textPlaceholderPredicate = NSPredicate(format: "label CONTAINS '-'")
        
        let placeholderItems = app.staticTexts.containing(textPlaceholderPredicate)
        
        XCTAssertEqual(placeholderItems.count, 3, "There should be 3 placeholdrs.")
    }
        
}
