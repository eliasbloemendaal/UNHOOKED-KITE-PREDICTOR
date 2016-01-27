//
//  PersonalRatingViewController.swift
//  KITEGURU
//
//  Created by Elias Houttuijn Bloemendaal on 17-01-16.
//  Copyright © 2016 Elias Houttuijn Bloemendaal. All rights reserved.
//

import UIKit

class PersonalRatingViewController: UIViewController {
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var weatherMoodLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var YourKiteLabel: UILabel!
    @IBOutlet weak var yourWetsuitsLabel: UILabel!
    @IBOutlet weak var HoodImage: UIImageView!
    @IBOutlet weak var GlovesImage: UIImageView!
    @IBOutlet weak var BootsImage: UIImageView!
    @IBOutlet weak var YourWeightLabel: UILabel!
    
    @IBOutlet weak var oneLabel: UILabel!
    @IBOutlet weak var twoLabel: UILabel!
    @IBOutlet weak var threeLabel: UILabel!
    @IBOutlet weak var fourLabel: UILabel!
    @IBOutlet weak var fiveLabel: UILabel!
    @IBOutlet weak var sixLabel: UILabel!
    @IBOutlet weak var sevenLabel: UILabel!
    @IBOutlet weak var eightLabel: UILabel!
    @IBOutlet weak var nineLabel: UILabel!
    @IBOutlet weak var tenLabel: UILabel!
    @IBOutlet weak var finalLabel: UILabel!
    @IBOutlet weak var adviesLabel: UILabel!
    
    var city: String?
    var temp: Double?
    var desc: String?
    var icon: String?
    var speed: Double?
    var deg: Double?
    var seaTemp: Double?
    var kiteguruAdvise: Double?
    var adviseKite: Double?
    var adviseWetsuitThickness: Double?
    var adviseWetsuitBoots: String?
    var adviseWetsuitHood: String?
    var adviseWetsuitGloves: String?
    var kiteArray: [Double] = []
    var wetsuitArray: [String] = []
    var kiteguruFinalAdvise: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            if temp == nil || speed == nil || deg == nil || icon == nil || city == nil {
                temp = 0
                speed = 0
                deg = 0
                icon = "02n"
                city = " city "
            }else{
                tempLabel.text = String(format: "%.2f", temp!) + " Celsius"
                windSpeedLabel.text = String(format: "%.2f", speed!) + " Knots"
                windDirectionLabel.text = String(format: "%.2f", deg!) + " Deg"
                weatherMoodLabel.text = desc
                cityLabel.text = city
                imageView.image = UIImage(named: icon!)
            }
        
        let query = PFUser.query()
        query!.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId!)!) {
            (PFUser: PFObject?, error: NSError?) -> Void in
            if error == nil && PFUser != nil {
                print(PFUser)
                self.YourKiteLabel.text = self.trimString(String(PFUser!["PersonalKites"]))
                self.yourWetsuitsLabel.text = self.trimString(String(PFUser!["PersonalWetsuits"]))
                self.HoodImage.image = UIImage(named: self.trimString(String(PFUser!["Hoods"])))
                self.BootsImage.image = UIImage(named: self.trimString(String(PFUser!["Boots"])))
                self.GlovesImage.image = UIImage(named: self.trimString(String(PFUser!["Gloves"])))
                self.YourWeightLabel.text = self.trimString(String(PFUser!["Weight"]))
                let weightNumber = Double(self.trimString(String(PFUser!["Weight"])))
                let knots = Double(self.speed!)
                self.kiteguruFinalAdvise = 8
                
                // Rekenmodel, hoeveel vierkante meter kite geschikt is voor de locatie
                
                if knots < 6 {
                    self.adviseKite = 0
                }else if knots >= 6 && knots < 8{
                    self.adviseKite = (((weightNumber!/knots) * 1.6) - 1)
                    print(String(self.adviseKite))
                }else if knots >= 8 && knots <= 12{
                    self.adviseKite = (((weightNumber!/knots) * 1.8) - 1)
                    print(self.adviseKite)
                }else if knots > 12 && knots <= 15{
                    self.adviseKite = (weightNumber!/knots) * 2.2
                    print(self.adviseKite)
                }else if knots > 15 && knots <= 25{
                    self.adviseKite = (weightNumber!/knots) * 2.6
                    print(self.adviseKite)
                }else if knots > 25{
                    self.adviseKite = (weightNumber!/knots) * 2.9
                    print(self.adviseKite)
                }
                
                print(Double(String(format: "%.0f", self.adviseKite!))!)
                
//                print(self.adviseKite!)
                
                print(self.temp!)
                self.seaTemp = (self.temp!) - 4
                print(self.seaTemp!)
                
                // Rekenmodel voor het wetsuit, hoeveel milimeter er nodig is
                if self.seaTemp < 6 {
                    self.adviseWetsuitThickness = 6
                    if self.trimString(String(PFUser!["Boots"])) == "redcross" {
                        self.kiteguruFinalAdvise! -= 2
                    }
                    
                    if self.trimString(String(PFUser!["Hoods"])) == "redcross" {
                        self.kiteguruFinalAdvise! -= 1
                    }
                    
                    if (self.trimString(String(PFUser!["Gloves"]))) == "redcross" {
                        self.kiteguruFinalAdvise! -= 1
                    }
                }
                else if self.seaTemp >= 6 && self.seaTemp < 9 {
                    self.adviseWetsuitThickness = 5
                    if (self.trimString(String(PFUser!["Boots"]))) == "redcross" {
                        self.kiteguruFinalAdvise! -= 1
                    }
                }
                else if self.seaTemp >= 9 && self.seaTemp < 12 {
                    self.adviseWetsuitThickness = 4
                }
                else if self.seaTemp >= 12 && self.seaTemp < 15 {
                    self.adviseWetsuitThickness = 3
                }
                else if self.seaTemp >= 15 && self.seaTemp < 19 {
                    self.adviseWetsuitThickness = 2
                }
                else if self.seaTemp >= 19 {
                    self.adviseWetsuitThickness = 0
                }
                print(self.adviseWetsuitThickness!)
                
                let personalWetsuits = self.trimString(String(PFUser!["PersonalWetsuits"]))
                print(personalWetsuits)
                let strr = self.trimThaString(personalWetsuits)
                let string_arrr =  strr.characters.split {$0 == " "}.map(String.init)
                print(string_arrr)
                for wetsuits in string_arrr {
                    let closestWetsuit = (Double(wetsuits)! - self.adviseWetsuitThickness!)
                    self.wetsuitArray.append(String(abs(closestWetsuit)))
                }
                
                for wetsuit in self.wetsuitArray {
                    print(wetsuit)
                }
                
                let minimumWetsuit = self.wetsuitArray.minElement()
                print(minimumWetsuit!)
                
                if Double(minimumWetsuit!) == 0 {
                    print(self.kiteguruFinalAdvise!)
                }
                else if Double(minimumWetsuit!) == 1 {
                    self.kiteguruFinalAdvise = (self.kiteguruFinalAdvise! - 1)
                }
                else if Double(minimumWetsuit!) == 2 {
                    self.kiteguruFinalAdvise = self.kiteguruFinalAdvise! - 3
                }
                else if Double(minimumWetsuit!) == 3 {
                    self.kiteguruFinalAdvise = self.kiteguruFinalAdvise! - 5
                }
                
                print(self.kiteguruFinalAdvise)
                
                
                let personalKites = self.trimString(String(PFUser!["PersonalKites"]))
                
                print(personalKites)
                
                let str = self.trimThaString(personalKites)

                let string_arr =  str.characters.split {$0 == " "}.map(String.init)
                print(string_arr)
                for kites in string_arr {
                    let closestKite = (Double(kites)! - self.adviseKite!)
                    let closestRoundKites = round(closestKite)
                    self.kiteArray.append(abs(closestRoundKites))
                }

                for kites in self.kiteArray {
                    print(kites)
                }
                
                let minimumKite = self.kiteArray.minElement()
                print(minimumKite)
                print(minimumKite)

                if Double(minimumKite!) == 0 {
                    print(self.kiteguruFinalAdvise!)
                }
                else if Double(minimumKite!) == 1 {
                    self.kiteguruFinalAdvise = self.kiteguruFinalAdvise! - 1
                }
                else if Double(minimumKite!) == 2 {
                    self.kiteguruFinalAdvise = self.kiteguruFinalAdvise! - 2
                }
                else if Double(minimumKite!) == 3 {
                    self.kiteguruFinalAdvise = self.kiteguruFinalAdvise! - 3
                }
                else if Double(minimumKite!) >= 4 {
                    self.kiteguruFinalAdvise = self.kiteguruFinalAdvise! - 5
                    if self.adviseKite == 0.0 {
                        self.kiteguruFinalAdvise = 1
                    }
                }
                
                print(self.kiteguruFinalAdvise!)
                if self.kiteguruFinalAdvise == 8 && self.kiteguruFinalAdvise == 7 {
                    if self.seaTemp >= 25{
                       self.kiteguruFinalAdvise! += 1
                    }
                    
                    if self.description == "clear sky" {
                        self.kiteguruFinalAdvise! += 1
                    }

                }
                
                if self.adviseKite == 0 {
                    self.kiteguruFinalAdvise! = 1
                }
                
                if self.kiteguruFinalAdvise == 0 {
                    self.oneLabel.text = "1"
                    self.finalLabel.text = "1"
                    self.oneLabel.textColor = UIColor.blueColor()
                    self.finalLabel.textColor = UIColor.blueColor()
                    //                    self.adviesLabel.text =
                }
                else if self.kiteguruFinalAdvise == 1 {
                    self.oneLabel.text = "1"
                    self.finalLabel.text = "1"
                    self.oneLabel.textColor = UIColor.blueColor()
//                    self.finalLabel.textColor = UIColor.blueColor()
//                    self.adviesLabel.text =
                }
                else if self.kiteguruFinalAdvise == 2 {
                    self.twoLabel.text = "2"
                    self.finalLabel.text = "2"
                    self.twoLabel.textColor = UIColor.blueColor()
//                    self.finalLabel.textColor = UIColor.redColor()
//                    self.adviesLabel.text =
                    
                }
                else if self.kiteguruFinalAdvise == 3 {
                    self.threeLabel.text = "3"
                    self.finalLabel.text = "3"
                    self.threeLabel.textColor = UIColor.blueColor()
//                    self.finalLabel.textColor = UIColor.blueColor()
//                    self.adviesLabel.text =
                }
                else if self.kiteguruFinalAdvise == 4 {
                    self.fourLabel.text = "4"
                    self.finalLabel.text = "4"
                    self.fourLabel.textColor = UIColor.blueColor()
//                    self.finalLabel.textColor = UIColor.blueColor()
                    //                    self.adviesLabel.text =
                }
                else if self.kiteguruFinalAdvise == 5 {
                    self.fiveLabel.text = "5"
                    self.finalLabel.text = "5"
                    self.fiveLabel.textColor = UIColor.blueColor()
//                    self.finalLabel.textColor = UIColor.blueColor()
                    //                    self.adviesLabel.text =
                }
                else if self.kiteguruFinalAdvise == 6 {
                    self.sixLabel.text = "6"
                    self.finalLabel.text = "6"
                    self.sixLabel.textColor = UIColor.blueColor()
//                    self.finalLabel.textColor = UIColor.blueColor()
                    //                    self.adviesLabel.text =
                }
                else if self.kiteguruFinalAdvise == 7 {
                    self.sevenLabel.text = "7"
                    self.finalLabel.text = "7"
                    self.sevenLabel.textColor = UIColor.blueColor()
//                    self.finalLabel.textColor = UIColor.blueColor()
                    //                    self.adviesLabel.text =
                }
                else if self.kiteguruFinalAdvise == 8 {
                    self.eightLabel.text = "8"
                    self.finalLabel.text = "8"
                    self.eightLabel.textColor = UIColor.blueColor()
//                    self.finalLabel.textColor = UIColor.blueColor()
                    //                    self.adviesLabel.text =
                }
                else if self.kiteguruFinalAdvise == 9 {
                    self.nineLabel.text = "9"
                    self.finalLabel.text = "9"
                    self.nineLabel.textColor = UIColor.blueColor()
//                    self.finalLabel.textColor = UIColor.blueColor()
                    //                    self.adviesLabel.text =
                }
                else if self.kiteguruFinalAdvise == 10 {
                    self.tenLabel.text = "10"
                    self.finalLabel.text = "10"
                    self.tenLabel.textColor = UIColor.blueColor()
//                    self.finalLabel.textColor = UIColor.blueColor()
                    //                    self.adviesLabel.text =
                }

            } else {
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

//        /// Rounds the double to decimal places value
//    func roundToPlaces(places:Int) -> Double {
//        let divisor = pow(10.0, Double(places))
//        return round(self * divisor) / divisor
//    }

    @IBAction func sendMail(sender: AnyObject) {
        screenShotMethod()
        performSegueWithIdentifier("adviseToMail", sender: nil)

    }
    
    @IBAction func LogOutButton(sender: AnyObject) {
        print("hij zit in de log out button")
        PFUser.logOut()
        let currentUser = PFUser.currentUser() // this will now be nil
        print(currentUser)
        performSegueWithIdentifier("logOutSignIn", sender: nil)
    }
    
    func trimString(UntrimmedString: String) -> String {
        let text = String(UntrimmedString)
        let textWithoutNewLines = text.stringByReplacingOccurrencesOfString("\n", withString: "")
        let textWithoutLeftComma = textWithoutNewLines.stringByReplacingOccurrencesOfString("(", withString: "")
        let textWithoutRightComma = textWithoutLeftComma.stringByReplacingOccurrencesOfString(")", withString: "")
        let textWithoutSpace = textWithoutRightComma.stringByReplacingOccurrencesOfString(" ", withString: "")
        let textChanged = textWithoutSpace.stringByReplacingOccurrencesOfString(",", withString: "-")
        return textChanged
    }
    
    func trimThaString(UntrimmedString: String) -> String {
        let text = String(UntrimmedString)
        let textChanged = text.stringByReplacingOccurrencesOfString("-", withString: " ")
        return textChanged
    }
    

    func screenShotMethod() {
        let layer = UIApplication.sharedApplication().keyWindow!.layer
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
    }

}

