//
//  ViewController.swift
//  UITestingSampleApp
//
//  Created by Jmango on 9/16/16.
//  Copyright © 2016 fruitful. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func login(sender: AnyObject) {
        if ValidateHelper.validateEmptyTextField(usernameTextField.text!) {
            showAlert("Oops", message: "Empty username")
            return
        }
        
        if ValidateHelper.validateEmptyTextField(passwordTextField.text!) {
            showAlert("Oops", message: "Empty password")
            return
        }
        
        if ValidateHelper.validateUsernameAndPasswordMatch(usernameTextField.text!, pass: passwordTextField.text!){
            self.performSegueWithIdentifier("loginSegue", sender: self)
        } else {
            showAlert("Oops", message: "Not matched")
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    

}

