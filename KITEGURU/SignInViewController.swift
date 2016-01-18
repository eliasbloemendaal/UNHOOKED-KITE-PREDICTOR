//
//  SignInViewController.swift
//  KITEGURU
//
//  Created by Elias Houttuijn Bloemendaal on 13-01-16.
//  Copyright © 2016 Elias Houttuijn Bloemendaal. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityLabel: UILabel!
    
    @IBOutlet weak var SettingButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var FreeWeatherButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SettingButton.hidden = true
        // delegate variables
        userName.delegate = self
        password.delegate = self
        self.activityIndicator.hidden = true

        // Do any additional setup after loading the view.
    }

    @IBAction func logInButton(sender: AnyObject) {

        ///////////////////////// Video V8 Login Async ///////////////
        if SignIn.hasEmptyFields(userName.text!, password: password.text!) {
            self.errorLabel.text = Error.incorrectSignIn.description
            return
        }
        self.activityIndicator.hidden = false
        activityIndicator.startAnimating()
        errorLabel.text = "Logging In Now..."
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0))
            {
                SignIn.loginUserAsync(self.userName.text!, password: self.password.text!, completion:
                    { (success: Bool) -> Void in
                        //update UI
                        if success
                        {
                                self.SignUpButton.enabled = false
                                self.FreeWeatherButton.enabled = false
                            dispatch_async(dispatch_get_main_queue())
                                {
                                    ParseModel.delay(seconds: 2, completion: {
                                        print("Login successful")
                                        self.errorLabel.text = "Login Successful"
                                        ParseModel.delay(seconds: 1.5, completion:
                                            {
                                                self.performSegueWithIdentifier("jaap", sender: nil)
                                                self.activityIndicator.stopAnimating()
                                                self.activityIndicator.hidden = true
                                                self.userName.text = ""
                                                self.password.text = ""
                                                self.errorLabel.text = ""
                                                self.SignUpButton.enabled = true
                                                self.FreeWeatherButton.enabled = true
                                        })
                                    })
                            }
                        }
                        else
                        {
                            dispatch_async(dispatch_get_main_queue())
                                {
                                    self.activityIndicator.stopAnimating()
                                    self.userName.resignFirstResponder()
                                    self.activityLabel.text = ""
                                    self.errorLabel.text = Error.incorrectSignIn.description
                            }
                        }
                })
        }
    }
    
    
    @IBAction func FreeWeatherButton(sender: AnyObject) {
        self.errorLabel.text = ""
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

}
