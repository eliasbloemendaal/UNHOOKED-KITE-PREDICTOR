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
    @IBOutlet weak var singUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstName.delegate = self
        lastName.delegate = self
        userName.delegate = self
        userEmail.delegate = self
        password.delegate = self
        confirmPassword.delegate = self
        navigationController?.navigationBarHidden
        
        // http://stackoverflow.com/questions/26614395/swift-background-image-does-not-fit-showing-small-part-of-the-all-image
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "kiteBackTwoo")
        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        //https://teamtreehouse.com/community/how-do-i-make-a-rounded-button-with-a-border-in-swift
        singUpButton.layer.cornerRadius = 10
    }
    
    //https://teamtreehouse.com/community/how-do-i-make-a-rounded-button-with-a-border-in-swift
    
    // Signup button maakt een nieuwe row aan op parse
    @IBAction func signUpButton(sender: AnyObject) {
        errorLabel.text = ""
        let signup = SignUp(fName: firstName.text!, lName: lastName.text!, uName: userName.text!, email: userEmail.text!, pass: password.text!, confirmPass: confirmPassword.text!)
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
    
    // Als er buiten het onscreen keyboard word geklikt zal de keyboard verdwijnen
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Laat een alert ziten die de mogelijkheid geeft om inteloggen en het scherm te verlaten
    func showSuccessAlert() {
        let alertview = UIAlertController(title: "Sign Up Successful", message: "Now you can Login for complete access", preferredStyle: .Alert)
        alertview.addAction(UIAlertAction(title: "Login", style: .Default, handler:
            { (alertAction) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
        }))
        alertview.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(alertview, animated: true, completion: nil)
    }
    
    // Viewcontroller zal weg gaan wnn dit aangeroepen wordt
    @IBAction func alreadyAUserBtnTouched(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
