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
    @IBOutlet weak var PersonalWeight: UILabel!
    @IBOutlet weak var KiteTextField: UITextField!
    @IBOutlet weak var WetsuitTextField: UITextField!
    @IBOutlet weak var WeightTextfield: UITextField!
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var PersonalBootImage: UIImageView!
    @IBOutlet weak var personalHoodImage: UIImageView!
    @IBOutlet weak var personalGlovesImage: UIImageView!
    
    
    var Kites: String?
    var Wetsuits: String?
    var Gloves: String?
    var Glovess: String?
    var Boots: String?
    var Bootss: String?
    var Hoods: String?
    var Hoodss: String?
    var Weight: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = PFUser.query()
        query!.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId!)!) {
            (PFUser: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let PFUser = PFUser {
                self.PersonalKiteLabel.text = self.trimString(String(PFUser["PersonalKites"]))
                self.PersonalWetsuitLabel.text = self.trimString(String(PFUser["PersonalWetsuits"]))
                self.personalHoodImage.image = UIImage(named: self.trimString(String(PFUser["Boots"])))
                self.personalGlovesImage.image = UIImage(named: self.trimString(String(PFUser["Gloves"])))
                self.PersonalBootImage.image = UIImage(named: self.trimString(String(PFUser["Hoods"])))
                self.PersonalWeight.text = self.trimString(String(PFUser["Weight"]))
                print(PFUser)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addYourWeightButton(sender: AnyObject) {
        let query = PFUser.query()
        query!.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId!)!) {
            (PFUser: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let PFUser = PFUser {
                self.Weight = self.WeightTextfield.text
                if self.checkQuantityCharactersDos(self.Weight!) == false {
                    PFUser["Weight"] = [self.Weight!]
                    PFUser.saveInBackground()
                    self.PersonalWeight.text = String(self.Weight!)
                    print(PFUser)
                    self.ErrorLabel.text = ""
                }
                else {
                    self.ErrorLabel.text = "Just two or three numbers!"
                }
            }else {
                print(PFUser)
            }
        }
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
                
                if self.containsOnlyNumbersAndSlash(self.Wetsuits!) {
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
                        self.ErrorLabel.text = " Just one character! "
                    }
                }else{
                    self.ErrorLabel.text = "Just one character!"
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
                
                if self.containsOnlyNumbersAndSlash(self.Wetsuits!) == true {
                    
                    if self.checkQuantityCharacters(self.Wetsuits!) == true {
                        
                        PFUser.removeObjectsInArray([self.Wetsuits!], forKey:"PersonalWetsuits")
                        let wetsuit = self.trimString(String(PFUser["PersonalWetsuits"]))
                        self.PersonalWetsuitLabel.text = wetsuit
                        PFUser.saveInBackground()
                        print(self.checkQuantityCharacters(self.Wetsuits!))
                        print(self.containsOnlyNumbersAndSlash(self.Wetsuits!))
                        print(PFUser)
                        self.ErrorLabel.text = ""
//                        PFUser["PersonalWetsuits"] = []
                    }
                    else
                    {
                        self.ErrorLabel.text = " Just one character!"
                    }
                }
                else
                {
                    self.ErrorLabel.text = " Just one character!"
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
    
    @IBAction func hoodButton(sender: AnyObject) {
        let query = PFUser.query()
        query!.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId!)!) {
            (PFUser: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let PFUser = PFUser {
                if self.personalHoodImage.image == UIImage(named: "wetsuitBoots") {
                    self.personalHoodImage.image = UIImage(named: "redcross")
                    self.Boots = "redcross"
                    self.Bootss = "wetsuitBoots"
                    PFUser["Boots"] = [self.Boots!]
                    PFUser.saveInBackground()
                    print(PFUser)
                }else if self.personalHoodImage.image == UIImage(named: "redcross") {
                    self.personalHoodImage.image = UIImage(named: "wetsuitBoots")
                    self.Boots = "redcross"
                    self.Bootss = "wetsuitBoots"
                    PFUser["Boots"] = [self.Bootss!]
                    PFUser.saveInBackground()
                    print(PFUser)
                }
            }
        }
    }
    
    @IBAction func bootsButton(sender: AnyObject) {
        let query = PFUser.query()
        query!.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId!)!) {
            (PFUser: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let PFUser = PFUser {
                if self.PersonalBootImage.image == UIImage(named: "wetsuitHood") {
                    self.PersonalBootImage.image = UIImage(named: "redcross")
                    self.Hoods = "redcross"
                    self.Hoodss = "wetsuitHood"
                    PFUser["Hoods"] = [self.Hoods!]
                    PFUser.saveInBackground()
                    print(PFUser)
                }else if self.PersonalBootImage.image == UIImage(named: "redcross") {
                    self.PersonalBootImage.image = UIImage(named: "wetsuitHood")
                    self.Hoods = "redcross"
                    self.Hoodss = "wetsuitHood"
                    PFUser["Hoods"] = [self.Hoodss!]
                    PFUser.saveInBackground()
                    print(PFUser)
                }
            }
        }
    }

    @IBAction func GlovesButton(sender: AnyObject) {
        let query = PFUser.query()
        query!.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId!)!) {
            (PFUser: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let PFUser = PFUser {
                if self.personalGlovesImage.image == UIImage(named: "wetsuitGloves") {
                    self.personalGlovesImage.image = UIImage(named: "redcross")
                    self.Gloves = "redcross"
                    self.Glovess = "wetsuitGloves"
                    PFUser["Gloves"] = [self.Gloves!]
                    PFUser.saveInBackground()
                    print(PFUser)
                }else if self.personalGlovesImage.image == UIImage(named: "redcross") {
                    self.personalGlovesImage.image = UIImage(named: "wetsuitGloves")
                    self.Gloves = "redcross"
                    self.Glovess = "wetsuitGloves"
                    PFUser["Gloves"] = [self.Glovess!]
                    PFUser.saveInBackground()
                    print(PFUser)
                }
            }
        }
    }
    
    func containsOnlyNumbers(input: String) -> Bool {
        for char in input.characters {
            if (!(char >= "0" && char <= "9")) {
                return false
            }
        }
        return true
    }
    
    func containsOnlyNumbersAndSlash(input: String) -> Bool {
        for char in input.characters {
            if (!(char >= "0" && char <= "9") && !(char == "/")) {
                return false
            }
        }
        return true
    }
    
    func checkQuantityCharacters(input: String) -> Bool {
        if input.characters.count != 1 {
            return false
        }
    return true
    }
    
    func checkQuantityCharactersDos(input: String) -> Bool {
        if input.characters.count == 2 || input.characters.count == 3 {
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
