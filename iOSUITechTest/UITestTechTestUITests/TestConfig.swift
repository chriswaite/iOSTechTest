//
//  TestConfig.swift
//  UITestTechTestUITests
//
//  Created by Christopher Waite on 05/11/2020.
//  Copyright © 2020 Just Eat. All rights reserved.
//

import XCTest

class TestConfig: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        
        continueAfterFailure = false
        app.launch()
        
        
        
    }

    override func tearDownWithError() throws {
        
    }

}
