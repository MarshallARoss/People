//
//  PeopleUITests.swift
//  PeopleUITests
//
//  Created by Marshall  on 9/9/22.
//

import XCTest

class PeopleScreenUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-people-networking-success" : "1"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func test_grid_has_correct_number_of_items_when_screen_loads() {
        
        let grid = app.otherElements["peopleGrid"]
        XCTAssertTrue(grid.waitForExistence(timeout: 5), "The People Lazygrid should be visible")
        
        let predicate = NSPredicate(format: "identifier CONTAINS 'item_'")
        let gridItems = grid.buttons.containing(predicate)
        
        XCTAssertEqual(gridItems.count, 6, "There should be 6 items")
        //see children by typing po grid.children(matching: .any) in the console when break point hit.
        
        XCTAssertTrue(gridItems.staticTexts["1"].exists)
        XCTAssertTrue(gridItems.staticTexts["George Bluth"].exists)        
    }
    
    
}
