//
//  UITestingSampleAppUITests.swift
//  UITestingSampleAppUITests
//
//  Created by Jmango on 9/16/16.
//  Copyright © 2016 fruitful. All rights reserved.
//

import XCTest

class UITestingSampleAppUITests: XCTestCase {
        
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
        app.buttons["login"].tap()
        app.alerts["Oops"].collectionViews.buttons["OK"].tap()
        
        let isEmptyUsername = ValidateHelper.validateEmptyTextField(usernameTextField.value as! String)
        XCTAssertEqual(isEmptyUsername, true)
    }
    
    func testEmptyPassword() {
        
        let app = XCUIApplication()
        let usernameTextField = app.textFields["username"]
        tapElementAndWaitForKeyboardToAppear(usernameTextField)
        usernameTextField.typeText("a")
        
        let passwordSecureTextField = app.secureTextFields["password"]
        tapElementAndWaitForKeyboardToAppear(passwordSecureTextField)
        app.buttons["login"].tap()
        app.alerts["Oops"].collectionViews.buttons["OK"].tap()
        
        let isEmptyPassword = ValidateHelper.validateEmptyTextField(passwordSecureTextField.value as! String)
        XCTAssertEqual(isEmptyPassword, true)
    }

    func testUsernameAndPasswordMatched() {
        
        let app = XCUIApplication()
        let usernameTextField = app.textFields["username"]
        tapElementAndWaitForKeyboardToAppear(usernameTextField)
        usernameTextField.typeText("a")
        
        let passwordTextField = app.secureTextFields["password"]
        tapElementAndWaitForKeyboardToAppear(passwordTextField)
        passwordTextField.typeText("1")
        app.buttons["login"].tap()
        app.alerts["Oops"].collectionViews.buttons["OK"].tap()
        
        
        let isMatched = ValidateHelper.validateUsernameAndPasswordMatch(String(usernameTextField.value), pass: String(passwordTextField.value))
        XCTAssertTrue(isMatched)
    }
    
    func testUsernameAndPasswordNotMached() {
        
        let app = XCUIApplication()
        let usernameTextField = app.textFields["username"]
        tapElementAndWaitForKeyboardToAppear(usernameTextField)
        usernameTextField.typeText("a")
        
        let passwordTextField = app.secureTextFields["password"]
        tapElementAndWaitForKeyboardToAppear(passwordTextField)
        passwordTextField.typeText("a")
        app.buttons["login"].tap()
        app.alerts["Oops"].collectionViews.buttons["OK"].tap()
        
        let isNotMatched = ValidateHelper.validateUsernameAndPasswordMatch(usernameTextField.value as! String, pass: passwordTextField.value as! String)
        XCTAssertFalse(isNotMatched)

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
