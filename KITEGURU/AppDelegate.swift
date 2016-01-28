//
//  AppDelegate.swift
//  KITEGURU
//
//  Created by Elias Houttuijn Bloemendaal on 07-01-16.
//  Copyright © 2016 Elias Houttuijn Bloemendaal. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        

        
        // Override point for customization after application launch.
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("teYJdF1mt9TsOO3FFBTjiSE4K2iQJNinVDqPjzjK",
            clientKey: "QIgJxYSrazSlRWCl5GSDN8nZxLNOxVd6dMhJUSW0")
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let currentUser = PFUser.currentUser()
        
        // If the current user is logged in, the application will op in an other viewcontroller
        if currentUser != nil {
            window!.rootViewController = storyboard.instantiateViewControllerWithIdentifier("PersonalAccountViewController") as! UIViewController

        } else {
            window!.rootViewController = storyboard.instantiateViewControllerWithIdentifier("SingInViewController") as! UIViewController
        }
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

