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
    @IBOutlet weak var yourWeightButton: UILabel!
    @IBOutlet weak var addOrReplaceButton: UIButton!
    @IBOutlet weak var yourKitesButton: UILabel!
    @IBOutlet weak var addKiteButton: UIButton!
    @IBOutlet weak var removeKiteButton: UIButton!
    @IBOutlet weak var yourWetsuitButton: UILabel!
    @IBOutlet weak var addWetsuitButton: UIButton!
    @IBOutlet weak var removeWetsuitbutton: UIButton!
    @IBOutlet weak var hoodButton: UIButton!
    @IBOutlet weak var bootsButton: UIButton!
    @IBOutlet weak var glovesButton: UIButton!
    @IBOutlet weak var getWeatherDataButton: UIButton!
    @IBOutlet weak var theGearMeterButton: UIButton!
    
    // Variables voor deze view controller
    var Kites: String?
    var Weight: String?
    var Wetsuits: String?
    var Gloves: String?
    var Glovess: String?
    var Boots: String?
    var Bootss: String?
    var Hoods: String?
    var Hoodss: String?
    var functions = Functions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change the layout of the buttons
        yourWeightButton.layer.cornerRadius = 10
        addOrReplaceButton.layer.cornerRadius = 10
        yourKitesButton.layer.cornerRadius = 10
        addKiteButton.layer.cornerRadius = 10
        removeKiteButton.layer.cornerRadius = 10
        yourWetsuitButton.layer.cornerRadius = 10
        addWetsuitButton.layer.cornerRadius = 10
        removeWetsuitbutton.layer.cornerRadius = 10
        hoodButton.layer.cornerRadius = 10
        bootsButton.layer.cornerRadius = 10
        glovesButton.layer.cornerRadius = 10
        getWeatherDataButton.layer.cornerRadius = 10
        theGearMeterButton.layer.cornerRadius = 10
        
        // http://stackoverflow.com/questions/26614395/swift-background-image-does-not-fit-showing-small-part-of-the-all-image
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "kiteBackNine")
        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        //https://parse.com/docs/ios/guide#objects-updating-objects
        let query = PFUser.query()
        query!.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId!)!) {
            (PFUser: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let PFUser = PFUser {
                self.PersonalKiteLabel.text = self.functions.trimString(String(PFUser["PersonalKites"]))
                self.PersonalWetsuitLabel.text = self.functions.trimString(String(PFUser["PersonalWetsuits"]))
                self.personalHoodImage.image = UIImage(named: self.functions.trimString(String(PFUser["Boots"])))
                self.personalGlovesImage.image = UIImage(named: self.functions.trimString(String(PFUser["Gloves"])))
                self.PersonalBootImage.image = UIImage(named: self.functions.trimString(String(PFUser["Hoods"])))
                self.PersonalWeight.text = self.functions.trimString(String(PFUser["Weight"]))
                self.navigationItem.title = String(PFUser["FirstName"])
                
                // First time dat iemand inlogt moeten de plaatjes een waarde hebben
                if self.personalGlovesImage.image == nil && self.personalHoodImage.image == nil && self.PersonalBootImage.image == nil {
                    self.personalHoodImage.image = UIImage(named: "redcross")
                    self.PersonalBootImage.image = UIImage(named: "redcross")
                    self.personalGlovesImage.image = UIImage(named: "redcross")
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Update parse door je gewicht toetevoegen
    @IBAction func addYourWeightButton(sender: AnyObject) {
        let query = PFUser.query()
        query!.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId!)!) {
            (PFUser: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let PFUser = PFUser {
                self.Weight = self.WeightTextfield.text
                
                // Check of je eigen gewicht twee of drie getallen zijn
                if self.functions.checkQuantityCharactersDos(self.Weight!) == false {
                    PFUser["Weight"] = [self.Weight!]
                    PFUser.saveInBackground()
                    self.PersonalWeight.text = String(self.Weight!)
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
    
    // Update parse door kites toe tevoegen
    @IBAction func AddKitesButton(sender: AnyObject) {
        let query = PFUser.query()
        query!.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId!)!) {
            (PFUser: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let PFUser = PFUser {
                self.Kites = self.KiteTextField.text
                
                // Check of het alleen maar nummers zijn
                if self.functions.containsOnlyNumbers(self.Kites!) {
                    
                    // Check of het een of twee karaters zijn
                    if self.functions.checkQueantityCharactesrTwo(self.Kites!) == true {
                        PFUser.addObjectsFromArray([self.Kites!], forKey:"PersonalKites")
                        PFUser.saveInBackground()
                        let kitesString = self.functions.trimString(String(PFUser["PersonalKites"]))
                        self.PersonalKiteLabel.text = kitesString
                        self.ErrorLabel.text = ""
                    }else{
                        self.ErrorLabel.text = "Your kites are only possible between 4 and 26 m2!"
                    }
                }
                else
                {
                    self.ErrorLabel.text = "Just fill a 2 number in!"
                }
            }
        }
    }
    
    // Update parse door kites te removen
    @IBAction func RemoveKitesButton(sender: AnyObject) {
        let query = PFUser.query()
        query!.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId!)!) {
            (PFUser: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let PFUser = PFUser {
                self.Kites = self.KiteTextField.text
                
                // Check of het alleen maar nummer zijn
                if self.functions.containsOnlyNumbers(self.Kites!){
                    PFUser.removeObjectsInArray([self.Kites!], forKey:"PersonalKites")
                    let kitesString = self.functions.trimString(String(PFUser["PersonalKites"]))
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

    // Update parse door een wetsuit toe tevoegen
    @IBAction func AddWetsuitButton(sender: AnyObject) {
        let query = PFUser.query()
        query!.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId!)!) {
            (PFUser: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let PFUser = PFUser {
                self.Wetsuits = self.WetsuitTextField.text
                
                // Check of het alleen nummers zijn
                if self.functions.containsOnlyNumbers(self.Wetsuits!) {
//                  
                    // Check of het genoeg karakters zijn
                    if self.functions.checkQuantityCharacters(self.Wetsuits!){
                        PFUser.addObjectsFromArray([self.Wetsuits!], forKey:"PersonalWetsuits")
                        PFUser.saveInBackground()
                        let wetsuitString = self.functions.trimString(String(PFUser["PersonalWetsuits"]))
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

    // Update parse door wetsuit te removen
    @IBAction func RemoveWetsuitsButton(sender: AnyObject) {
        let query = PFUser.query()
        query!.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId!)!) {
            (PFUser: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let PFUser = PFUser {
                self.Wetsuits = self.WetsuitTextField.text
                
                if self.functions.containsOnlyNumbers(self.Wetsuits!) == true {
                    
                    if self.functions.checkQuantityCharacters(self.Wetsuits!) == true {
                        PFUser.removeObjectsInArray([self.Wetsuits!], forKey:"PersonalWetsuits")
                        let wetsuit = self.functions.trimString(String(PFUser["PersonalWetsuits"]))
                        self.PersonalWetsuitLabel.text = wetsuit
                        PFUser.saveInBackground()
                        self.ErrorLabel.text = ""
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
    
    // Update parse door hood toetevoegen of weg te halen
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
                }else if self.personalHoodImage.image == UIImage(named: "redcross") {
                    self.personalHoodImage.image = UIImage(named: "wetsuitBoots")
                    self.Boots = "redcross"
                    self.Bootss = "wetsuitBoots"
                    PFUser["Boots"] = [self.Bootss!]
                    PFUser.saveInBackground()
                }
            }
        }
    }
    
    // Update parse door boots te toetevoegen of weg te halen
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
                }else if self.PersonalBootImage.image == UIImage(named: "redcross") {
                    self.PersonalBootImage.image = UIImage(named: "wetsuitHood")
                    self.Hoods = "redcross"
                    self.Hoodss = "wetsuitHood"
                    PFUser["Hoods"] = [self.Hoodss!]
                    PFUser.saveInBackground()
                }
            }
        }
    }

    // Update parse door te gloves weg te halen of toetevoegen
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
    
    // Log out button, logt de current user uit en zal de viewController veranderen
    @IBAction func LogOutButton(sender: AnyObject) {
        PFUser.logOut()
        var currentUser = PFUser.currentUser()
        performSegueWithIdentifier("logOutPersonalAccount", sender: nil)
    }
    
    // Als er buiten het keyboard wordt geklikt gaat het keyboard weg
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}
