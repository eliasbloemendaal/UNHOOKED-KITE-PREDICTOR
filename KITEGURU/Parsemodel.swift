//
//  Parsemodel.swift
//  KITEGURU
//
//  Created by Elias Houttuijn Bloemendaal on 14-01-16.
//  Copyright © 2016 Elias Houttuijn Bloemendaal. All rights reserved.
//

import Foundation

//https://github.com/kevincaughman/Resume-App/tree/master/Models
//The parsemodel from kevin caughman.
class ParseModel {
    
    static func delay(seconds seconds: Double, completion:()->()) {
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
        
        dispatch_after(popTime, dispatch_get_main_queue()) {
            completion()
        }
    }
    
    func loginUserAsync(email: String, password: String, completion:(success:Bool) -> Void)
    {
        
        PFUser.logInWithUsernameInBackground(email, password: password)
            { userHandler -> Void in
                
                if userHandler.1 == nil && userHandler.0 != nil
                {
                    completion(success: true)
                }
                else
                {
                    completion(success: false)
                }
            }
    }

}
