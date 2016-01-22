//
//  PersonalRatingViewController.swift
//  KITEGURU
//
//  Created by Elias Houttuijn Bloemendaal on 17-01-16.
//  Copyright © 2016 Elias Houttuijn Bloemendaal. All rights reserved.
//

import UIKit

class PersonalRatingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let query = PFUser.query()
//        //    query!.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId!)!) {
//        //    (PFUser: PFObject?, error: NSError?)
//        var user = PFUser()
//        query!.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId!)!) {
//            (gameScore: PFObject?, error: NSError?) -> Void in
//            if error == nil && user != nil {
//                print(gameScore)
//            } else {
//                print(error)
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    @IBAction func LogOutButton(sender: AnyObject) {
        print("hij zit in de log out button")
        PFUser.logOut()
        var currentUser = PFUser.currentUser() // this will now be nil
        print(currentUser)
        performSegueWithIdentifier("logOutSignIn", sender: nil)
    }



}

