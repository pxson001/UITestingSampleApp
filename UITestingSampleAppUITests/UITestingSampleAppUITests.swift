//
//  UITestingSampleAppUITests.swift
//  UITestingSampleAppUITests
//
//  Created by Jmango on 9/16/16.
//  Copyright © 2016 fruitful. All rights reserved.
//

import XCTest

class UITestingSampleAppUITests: XCTestCase {
    
    let TIMEOUT = NSTimeInterval(60)
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    func testEmptyUsername() {
        
        let app = XCUIApplication()
        let usernameTextField = app.textFields["username"]
        tapElementAndWaitForKeyboardToAppear(usernameTextField)
        app.buttons["Log in"].tap()
        
        let alert = app.alerts.staticTexts["Empty username"]
        let predicate = NSPredicate(format: "exists = true")
        expectationForPredicate(predicate, evaluatedWithObject: alert, handler: nil)
        waitForExpectationsWithTimeout(TIMEOUT, handler: nil)
        XCTAssertTrue(alert.exists)
    }
    
    func testEmptyPassword() {
        
        let app = XCUIApplication()
        let usernameTextField = app.textFields["username"]
        tapElementAndWaitForKeyboardToAppear(usernameTextField)
        usernameTextField.typeText("a")
        
        let passwordSecureTextField = app.secureTextFields["password"]
        tapElementAndWaitForKeyboardToAppear(passwordSecureTextField)
        app.buttons["Log in"].tap()
        
        let alert = app.alerts.staticTexts["Empty password"]
        let predicate = NSPredicate(format: "exists = true")
        expectationForPredicate(predicate, evaluatedWithObject: alert, handler: nil)
        waitForExpectationsWithTimeout(TIMEOUT, handler: nil)
    }

    
    func testUsernameAndPasswordNotMached() {
        
        let app = XCUIApplication()
        let usernameTextField = app.textFields["username"]
        tapElementAndWaitForKeyboardToAppear(usernameTextField)
        usernameTextField.typeText("a")
        
        let passwordSecureTextField = app.secureTextFields["password"]
        tapElementAndWaitForKeyboardToAppear(passwordSecureTextField)
        passwordSecureTextField.typeText("a")
        app.buttons["Log in"].tap()
        
        let alert = app.alerts.staticTexts["Not matched"]
        let predicate = NSPredicate(format: "exists = true")
        expectationForPredicate(predicate, evaluatedWithObject: alert, handler: nil)
        waitForExpectationsWithTimeout(TIMEOUT, handler: nil)
    }
    
    func testUsernameAndPasswordMatched() {
        
        let app = XCUIApplication()
        let usernameTextField = app.descendantsMatchingType(.TextField).matchingIdentifier("username").element
        tapElementAndWaitForKeyboardToAppear(usernameTextField)
        usernameTextField.typeText("a")
        
        let passwordSecureTextField = app.secureTextFields["password"]
        tapElementAndWaitForKeyboardToAppear(passwordSecureTextField)
        passwordSecureTextField.typeText("1")
        app.buttons["Log in"].tap()
        
        
        let label = app.staticTexts["Main Screen"]
        let predicate = NSPredicate(format: "exists = true")
        expectationForPredicate(predicate, evaluatedWithObject: label, handler: nil)
        waitForExpectationsWithTimeout(TIMEOUT, handler: nil)
    }
}

extension XCTestCase {
    
    func tapElementAndWaitForKeyboardToAppear(element: XCUIElement) {
        let keyboard = XCUIApplication().keyboards.element
        while (true) {
            element.tap()
            if keyboard.exists {
                break;
            }
            NSRunLoop.currentRunLoop().runUntilDate(NSDate(timeIntervalSinceNow: 0.5))
        }
    }
}
