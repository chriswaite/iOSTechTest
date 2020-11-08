//
//  ActiveTaskTest.swift
//  UITestTechTestUITests
//
//  Created by Christopher Waite on 05/11/2020.
//  Copyright © 2020 Just Eat. All rights reserved.
//

import XCTest

class TestTasksScreens: TestConfig {
    
    let mainAddButton = Helpers().createElements().mainAddButton
    let popupAddButton = Helpers().createElements().popupAddButton
    let popupCancelButton = Helpers().createElements().popupCancelButton
    let archivedButton = Helpers().createElements().archivedButton
    let activeButton = Helpers().createElements().activeButton
    var activeTaskCount = 0
    var archivedTaskCount = 0
    
    
    // Active Task screen is displayed. Text labels are verified
    func testActiveTaskScreenInitialState() {
        
        Helpers().assertTextPresent(textToVerify: "Active Tasks", errorMessage: "Active List Page Title incorrect")
        activeTaskCountVerifier(activeTaskCount: activeTaskCount)
        Helpers().assertButtonIsPresent(buttonId: mainAddButton, active: true)
        Helpers().assertButtonIsPresent(buttonId: archivedButton, active: true)
    }
    
    func testArchiveTaskScreenInitialState() {
        
        Helpers().clickButton(buttonId: archivedButton)
        Helpers().assertTextPresent(textToVerify: "Completed Tasks", errorMessage: "Archive List Page Title incorrect")
        archivedTaskCountVerifier(archivedTaskCount: archivedTaskCount)
        Helpers().assertButtonIsNotPresent(buttonId: mainAddButton)
        Helpers().assertButtonIsPresent(buttonId: activeButton, active: true)
    }

    
    // Verify text on 'Add Task' pop up, select Cancel to close
    func testAddTaskPopUpScreenInitialState() {
        
        Helpers().clickButton(buttonId: mainAddButton)
        Helpers().assertTextPresent(textToVerify: "Add Task", errorMessage: "Add task field label incorrect")
        Helpers().assertTextPresent(textToVerify: "Add a new task to your list.", errorMessage: "Add task field label incorrect")
        Helpers().assertButtonIsPresent(buttonId: popupAddButton, active: true)
        Helpers().assertButtonIsPresent(buttonId: popupCancelButton, active: true)
        Helpers().clickButton(buttonId: popupCancelButton)
    }
        
    // Add multiple tasks to the list
    func testAddTasksToList() {

        addTaskToListAndVerifyTaskCount(textToAdd: "Test 1")
        addTaskToListAndVerifyTaskCount(textToAdd: "Test 2")
        
        // Add a 3rd Task using the pop up, but select Cancel button
        Helpers().clickButton(buttonId: mainAddButton)
        Helpers().addTextToOpenPopUp(textToAdd:"Test 3", popupAddButton: popupCancelButton)
        Helpers().assertTextPresent(textToVerify: String(activeTaskCount) + " tasks active.", errorMessage: "Active Tasks label incorrect")
    }

        
    //Add 2 tasks the to do list, 'Complete' one of them, verify 'Archived' List
    func testAddTasksToListAndComplete() {
        
        addTaskToListAndVerifyTaskCount(textToAdd: "Test 1")
        addTaskToListAndVerifyTaskCount(textToAdd: "Test 2")
        actionTaskInListAndVerifyCount(taskName: "Test 1", action: "Complete")
        Helpers().clickButton(buttonId: archivedButton)
        archivedTaskCountVerifier(archivedTaskCount: archivedTaskCount)

    }
    
    //Add 2 tasks the to do list, 'Delete' one of them
    func testAddTasksToListAndDelete() {
        
        addTaskToListAndVerifyTaskCount(textToAdd: "Test 1")
        addTaskToListAndVerifyTaskCount(textToAdd: "Test 2")
        actionTaskInListAndVerifyCount(taskName: "Test 1", action: "Delete")
    }
    
// -------------------------------------------------------------------------------------------------------------------------------------
// -------------------------------------------------------------------------------------------------------------------------------------
    
    func actionTaskInListAndVerifyCount(taskName: String, action: String){
        Helpers().actionTaskInList(taskName: taskName, action: action)
        activeTaskCount-=1
        activeTaskCountVerifier(activeTaskCount: activeTaskCount)
        if (action == "Complete"){
            archivedTaskCount+=1
        }
    }
    
    
    func addTaskToListAndVerifyTaskCount(textToAdd: String){
        Helpers().clickButton(buttonId: mainAddButton)
        Helpers().addTextToOpenPopUp(textToAdd:textToAdd, popupAddButton: popupAddButton)
        activeTaskCount+=1
        activeTaskCountVerifier(activeTaskCount: activeTaskCount)
    }
    
    
    
    func activeTaskCountVerifier(activeTaskCount: Int){
        if (activeTaskCount == 1) {
            Helpers().assertTextPresent(textToVerify: String(activeTaskCount) + " task active.", errorMessage: "Active Tasks label incorrect")
        } else {
            Helpers().assertTextPresent(textToVerify: String(activeTaskCount) + " tasks active.", errorMessage: "Active Tasks label incorrect")
        }
    }
    
    func archivedTaskCountVerifier(archivedTaskCount: Int){
        if (archivedTaskCount == 1) {
            Helpers().assertTextPresent(textToVerify: String(archivedTaskCount) + " task completed!", errorMessage: "Archive Tasks label incorrect")
        } else {
            Helpers().assertTextPresent(textToVerify: String(archivedTaskCount) + " tasks completed!", errorMessage: "Archive Tasks label incorrect")
        }
    }
}
