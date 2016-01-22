//
//  PersonalViewController.swift
//  KITEGURU
//
//  Created by Elias Houttuijn Bloemendaal on 14-01-16.
//  Copyright © 2016 Elias Houttuijn Bloemendaal. All rights reserved.
//

import UIKit

class PersonalAccountViewController: UIViewController {

    @IBOutlet weak var PersonalKiteLabel: UILabel!
    @IBOutlet weak var PersonalWetsuitLabel: UILabel!
    @IBOutlet weak var KiteTextField: UITextField!
    @IBOutlet weak var WetsuitTextField: UITextField!
    
    @IBOutlet weak var ErrorLabel: UILabel!
    var Kites: String?
    var Wetsuits: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = PFUser.query()
        query!.getObjectInBackgroundWithId("1AoX7eZiUv") {
            (PFUser: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let PFUser = PFUser {
                let kitesString = self.trimString(String(PFUser["PersonalKites"]))
                self.PersonalKiteLabel.text = kitesString
                
                let wetsuitString = self.trimString(String(PFUser["PersonalWetsuits"]))
                self.PersonalWetsuitLabel.text = wetsuitString
                print(PFUser)
            }
        }
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func AddKitesButton(sender: AnyObject) {
        let query = PFUser.query()
        query!.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId!)!) {
            (PFUser: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let PFUser = PFUser {
                self.Kites = self.KiteTextField.text
                if self.containsOnlyNumbers(self.Kites!) {
                    if self.checkQueantityCharactesrTwo(self.Kites!) == true {
    //                PFUser["PersonalKites"] = []
                        PFUser.addObjectsFromArray([self.Kites!], forKey:"PersonalKites")
                        PFUser.saveInBackground()
                        let kitesString = self.trimString(String(PFUser["PersonalKites"]))
                        self.PersonalKiteLabel.text = kitesString
                        self.ErrorLabel.text = ""
                        print(PFUser)
                    }else{
                        self.ErrorLabel.text = "Your kites are only possible between 4 and 26 m2!"
                    }
                }
                else
                {
                    self.ErrorLabel.text = "Just fill a number/numbers in!"
                }
            }
        }
    }
    
    @IBAction func RemoveKitesButton(sender: AnyObject) {
        let query = PFUser.query()
        query!.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId!)!) {
            (PFUser: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let PFUser = PFUser {
                self.Kites = self.KiteTextField.text
                if self.containsOnlyNumbers(self.Kites!){
                    PFUser.removeObjectsInArray([self.Kites!], forKey:"PersonalKites")
                    let kitesString = self.trimString(String(PFUser["PersonalKites"]))
                    self.PersonalKiteLabel.text = kitesString
                    PFUser.saveInBackground()
                    print(PFUser)
                    self.ErrorLabel.text = ""
                }else {
                    self.ErrorLabel.text = "Just fill 1 or 2 numbers in!"
                }
            }
        }

    }

    @IBAction func AddWetsuitButton(sender: AnyObject) {
        let query = PFUser.query()
        query!.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId!)!) {
            (PFUser: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let PFUser = PFUser {
                self.Wetsuits = self.WetsuitTextField.text
                
                if self.containsOnlyNumbersAndComma(self.Wetsuits!) {
//                
                    if self.checkQuantityCharacters(self.Wetsuits!){
//                        PFUser["PersonalWetsuits"] = []
                        PFUser.addObjectsFromArray([self.Wetsuits!], forKey:"PersonalWetsuits")
                        PFUser.saveInBackground()
                        let wetsuitString = self.trimString(String(PFUser["PersonalWetsuits"]))
                        self.PersonalWetsuitLabel.text = wetsuitString
                        print(PFUser)
                        self.ErrorLabel.text = ""
                    }else{
                        self.ErrorLabel.text = " You have to fill in 3 characters! "
                    }
                }else{
                    self.ErrorLabel.text = " Just fill 3 charcters in, for example 5/3 !"
                }
            }
        }
    }

    @IBAction func RemoveWetsuitsButton(sender: AnyObject) {
        let query = PFUser.query()
        query!.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId!)!) {
            (PFUser: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let PFUser = PFUser {
                self.Wetsuits = self.WetsuitTextField.text
                
                if self.containsOnlyNumbersAndComma(self.Wetsuits!) == true {
                    
                    if self.checkQuantityCharacters(self.Wetsuits!) == true {
                        
                        PFUser.removeObjectsInArray([self.Wetsuits!], forKey:"PersonalWetsuits")
                        let wetsuit = self.trimString(String(PFUser["PersonalWetsuits"]))
                        self.PersonalWetsuitLabel.text = wetsuit
                        PFUser.saveInBackground()
                        print(self.checkQuantityCharacters(self.Wetsuits!))
                        print(self.containsOnlyNumbersAndComma(self.Wetsuits!))
                        print(PFUser)
                        self.ErrorLabel.text = ""
//                                    PFUser["PersonalWetsuits"] = []
                    }
                    else
                    {
                        self.ErrorLabel.text = "You have to fill in 3 characters "
                    }
                }
                else
                {
                    self.ErrorLabel.text = " Just fill 3 charcters in, for example 5/3 !"
                }
            }
        }
    }
    
    @IBAction func LogOutButton(sender: AnyObject) {
        print("hij zit in de log out button")
        PFUser.logOut()
        var currentUser = PFUser.currentUser() // this will now be nil
        print(currentUser)
        performSegueWithIdentifier("logOutPersonalAccount", sender: nil)
    }
    
    func containsOnlyNumbers(input: String) -> Bool {
        for char in input.characters {
            if (!(char >= "0" && char <= "9")) {
                return false
            }
        }
        return true
    }
    
    func containsOnlyNumbersAndComma(input: String) -> Bool {
        for char in input.characters {
            if (!(char >= "0" && char <= "9") && !(char == "/")) {
                return false
            }
        }
        return true
    }
    
    func checkQuantityCharacters(input: String) -> Bool {
        if input.characters.count != 3 {
            return false
        }
    return true
    }
    
    func checkQueantityCharactesrTwo(input: String) -> Bool {
        if input.characters.count > 0 && input.characters.count < 3 {
            return true
        }
        return false
    }

    
//    func alphaCheck(input: String) -> Bool {
//        
//        for char in input.utf8 {
//            switch char {
//            case 65...90:
//                continue
//            case 97...122:
//                continue
//            default:
//                return false
//            }
//        }
//        return true
//    }
    
    func trimString(UntrimmedString: String) -> String {
        let text = String(UntrimmedString)
        let textWithoutNewLines = text.stringByReplacingOccurrencesOfString("\n", withString: "")
        let textWithoutLeftComma = textWithoutNewLines.stringByReplacingOccurrencesOfString("(", withString: "")
        let textWithoutRightComma = textWithoutLeftComma.stringByReplacingOccurrencesOfString(")", withString: "")
        let textWithoutSpace = textWithoutRightComma.stringByReplacingOccurrencesOfString(" ", withString: "")
        let textChanged = textWithoutSpace.stringByReplacingOccurrencesOfString(",", withString: "-")
        return textChanged

    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
