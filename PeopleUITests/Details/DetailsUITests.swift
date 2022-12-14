//
//  DetailsUITests.swift
//  PeopleUITests
//
//  Created by Marshall  on 9/13/22.
//

import XCTest
import SwiftUI

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
    
    func test_user_info_is_correct_when_item_is_tappen_screen_loads() {
        
        let grid = app.otherElements["peopleGrid"]
        
        XCTAssertTrue(grid.waitForExistence(timeout: 5), "The grid should exist")
        
        let predicate = NSPredicate(format: "identifier CONTAINS 'item_'")
        let gridItems = grid.buttons.containing(predicate)
        
        gridItems.firstMatch.tap()
        
        XCTAssertTrue(app.staticTexts["Details"].exists)
        XCTAssertTrue(app.staticTexts["1"].exists)
        XCTAssertTrue(app.staticTexts["First Name"].exists)
        XCTAssertTrue(app.staticTexts["George"].exists)
        XCTAssertTrue(app.staticTexts["Last Name"].exists)
        XCTAssertTrue(app.staticTexts["Bluth"].exists)
        XCTAssertTrue(app.staticTexts["Email"].exists)
        XCTAssertTrue(app.staticTexts["george.bluth@reqres.in"].exists)
    }
    
}
