//
//  ViewController.swift
//  KITEGURU
//
//  Created by Elias Houttuijn Bloemendaal on 07-01-16.
//  Copyright © 2016 Elias Houttuijn Bloemendaal. All rights reserved.
//
//
//import UIKit
//
//
//class MainViewController: UIViewController {
//
//    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(true)
//        
//        // use PFUser to see if there is a current user signed in
//        if PFUser.currentUser() != nil {
//        } else {
//            // take user to SignInViewController through a custom segue
//            self.performSegueWithIdentifier("signIn", sender: self)
//        }
//    }
//
//    @IBAction func logOutButton(sender: AnyObject) {
//        PFUser.logOut()
//        self.performSegueWithIdentifier("signIn", sender: self)
//    }
//}
//
