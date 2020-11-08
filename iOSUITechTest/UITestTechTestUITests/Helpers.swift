//
//  Helpers.swift
//  UITestTechTestUITests
//
//  Created by Christopher Waite on 08/11/2020.
//  Copyright © 2020 Just Eat. All rights reserved.
//

import Foundation
import XCTest


class Helpers: TestConfig {
    
    func createElements() -> (mainAddButton: XCUIElement, popupAddButton: XCUIElement, popupCancelButton: XCUIElement, archivedButton: XCUIElement, activeButton: XCUIElement) {
        
        let mainAddButton = app.buttons["Add"]
        let archivedButton = app.buttons["Archived"]
        let activeButton = app.buttons["Active"]
        let popupAddButton = app/*@START_MENU_TOKEN@*/.alerts["Add Task Panel"]/*[[".alerts[\"Add Task\"]",".alerts[\"Add Task Panel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.scrollViews.otherElements.buttons["Add"]
        let popupCancelButton = app/*@START_MENU_TOKEN@*/.alerts["Add Task Panel"]/*[[".alerts[\"Add Task\"]",".alerts[\"Add Task Panel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.scrollViews.otherElements.buttons["Cancel"]
        
        return (mainAddButton, popupAddButton, popupCancelButton, archivedButton, activeButton)
    }
    
    
    func clickButton(buttonId: XCUIElement) {
        let button = buttonId
        button.tap()
    }
    
    
    
    // Finds button on screen and checks active state
    func assertButtonIsPresent(buttonId: XCUIElement, active: Bool){
        XCTAssertTrue(buttonId.exists)
        XCTAssertTrue(active)
    }
    
    // Finds button on screen and checks active state
    func assertButtonIsNotPresent(buttonId: XCUIElement){
        XCTAssertFalse(buttonId.exists)
    }
    
    
    func assertTextPresent(textToVerify: String, errorMessage: String) {
        XCTAssertTrue(app.staticTexts[textToVerify].exists, errorMessage)
    }
    
       
    
    func addTextToOpenPopUp(textToAdd: String, popupAddButton: XCUIElement) {
        let textField = app.alerts.textFields["Add Task Text Field"]
        textField.tap()
        textField.typeText(textToAdd)
        clickButton(buttonId: popupAddButton)
    }
    
    
    
    func actionTaskInList(taskName: String, action: String) {
        let tablesQuery = app.tables
        let taskList = tablesQuery.staticTexts[taskName]
        taskList.swipeLeft()
        tablesQuery.buttons[action].tap()
    }
    
}





