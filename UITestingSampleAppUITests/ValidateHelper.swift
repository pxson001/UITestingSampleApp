//
//  ValidateHelper.swift
//  UITestingSampleApp
//
//  Created by Jmango on 9/16/16.
//  Copyright © 2016 fruitful. All rights reserved.
//

import Foundation


class ValidateHelper {
    
    static let username = "a"
    static let password = "1"
    
    
    static func validateEmptyTextField(text: String) -> Bool{
        return text.isEmpty
    }
    
    static func validateUsernameAndPasswordMatch(user: String, pass: String) -> Bool {
        if user == username && pass == password{
            return true
        }
        return false
    }
}