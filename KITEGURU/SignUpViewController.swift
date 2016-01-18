//
//  SignUpViewController.swift
//  KITEGURU
//
//  Created by Elias Houttuijn Bloemendaal on 13-01-16.
//  Copyright © 2016 Elias Houttuijn Bloemendaal. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate, UIAlertViewDelegate {

    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var kites: UITextField!
    @IBOutlet weak var wetsuites: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstName.delegate = self
        lastName.delegate = self
        userName.delegate = self
        userEmail.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
        kites.delegate = self
        wetsuites.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButton(sender: AnyObject) {
        errorLabel.text = ""
        
        
        let signup = SignUp(fName: firstName.text!, lName: lastName.text!, uName: userName.text!, email: userEmail.text!, pass: password.text!, confirmPass: confirmPassword.text!, kite: kites.text!, wetsuit: wetsuites.text!)
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0))
            {
                do {
                    try signup.checkAllRequirements()
                    
                    signup.saveUserAsync({ (result, success) -> Void in
                        if success {
                            self.showSuccessAlert()
                        }
                    })
                    
                } catch let error as Error {
                    dispatch_async(dispatch_get_main_queue()) { self.errorLabel.text = error.description }
                } catch {
                    dispatch_async(dispatch_get_main_queue()) { self.errorLabel.text = "Sorry something went wrong please try again" }
                }
        }
    }
    
    

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func showSuccessAlert() {
        let alertview = UIAlertController(title: "Sign Up Successful", message: "Now you can Login for complete access", preferredStyle: .Alert)
        alertview.addAction(UIAlertAction(title: "Login", style: .Default, handler:
            { (alertAction) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
        }))
        alertview.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(alertview, animated: true, completion: nil)
    }
    
    @IBAction func alreadyAUserBtnTouched(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
//    func signUpSuccesAlert() -> UIAlertController {
//        let alertview = UIAlertController(title: "Sign up succesful;" , message: "Now you can log in for complete access", preferredStyle: .Alert)
//         alertview.addAction(UIAlertAction(title: "login", style: .Default
//            ,handler: { (alertAction) -> Void in
//                self.dismissViewControllerAnimated(true, completion: nil)
//         }))
//        alertview.addAction(UIAlertAction(title: "Cancel", style: .Cancel , handler: nil))
//        
//        return alertview
//        
//    }

 

}
