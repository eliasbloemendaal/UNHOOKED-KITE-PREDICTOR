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

// https://github.com/kevincaughman/Resume-App/tree/master/Models
//
class SignIn {
    
    var logIn: Bool = false
    
    // Een check of the fields niet leeg zijn
    static func hasEmptyFields(userName: String, password: String) -> Bool {
        if userName.isEmpty || password.isEmpty {
            return true
        }
        return false
    }
    
    // Gebruik de username om in te loggen
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

