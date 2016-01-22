//
//  SignIn.swift
//  KITEGURU
//
//  Created by Elias Houttuijn Bloemendaal on 14-01-16.
//  Copyright © 2016 Elias Houttuijn Bloemendaal. All rights reserved.
//
import Foundation
import UIKit


typealias userHandler = (user: PFUser?, error: NSError?)

class SignIn {
    
  
    var logIn: Bool = false
    
    // Check to make sure none of the text fields on our sign up view are empty
    static func hasEmptyFields(userName: String, password: String) -> Bool {
        if userName.isEmpty || password.isEmpty {
            return true
        }
        return false
    }
    
    ////////// Video V8 Method ///////////////////
    
    // use logInWithUsername method to log in
    static func loginUserAsync(userName: String, password: String, completion:(success:Bool) -> Void)
    {
        
        let logIn = false
        PFUser.logInWithUsernameInBackground(userName, password: password)
            { (user: PFUser?, error: NSError?) -> Void in
                
                if error == nil {
                    completion(success: true)
                    let login = true
                    print(login)
                }
                else {
                    completion(success: false)
                    let login = false
                    print(login)
                    
                }
        }
        print(logIn)
    }

}

