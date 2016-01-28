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
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SettingButton.hidden = false
        // delegate variables
        userName.delegate = self
        password.delegate = self
        self.activityIndicator.hidden = true
        self.navigationController?.navigationBar.hidden = true
        self.SettingButton.hidden = true
        
        // http://stackoverflow.com/questions/26614395/swift-background-image-does-not-fit-showing-small-part-of-the-all-image
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "kiteBackOne")
        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        // https://teamtreehouse.com/community/how-do-i-make-a-rounded-button-with-a-border-in-swift
        SignUpButton.layer.cornerRadius = 10
        FreeWeatherButton.layer.cornerRadius = 10
        logInButton.layer.cornerRadius = 10
    }
    
    // Als de loginbutton aangetikt word, gaan een een antaal functies zich afspelen
    @IBAction func logInButton(sender: AnyObject) {

        // check if the fields are empty
        if SignIn.hasEmptyFields(userName.text!, password: password.text!) {
            self.errorLabel.text = Error.incorrectSignIn.description
            return
        }
        self.activityIndicator.hidden = false
        activityIndicator.startAnimating()
        errorLabel.text = "Logging In Now..."
        
        // https://github.com/kevincaughman/Resume-App/blob/master/Resume/SignInViewController.swift
        // extra button's worden disabled, textfield worden leeg gemaakt
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
    
    // free weather button zal de error weer clearen
    @IBAction func FreeWeatherButton(sender: AnyObject) {
        self.errorLabel.text = ""
    }
  
    // Segue als free weather predictionsbutton word aangeraakt
    @IBAction func freeWeatherpredicitonButton(sender: AnyObject) {
        performSegueWithIdentifier("freeWeatherSignIn", sender: nil)
        
    }
    
    // Als de user klaar is met het keyboard verdwijnt als er buiten het keyboard word gedrukt
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}
