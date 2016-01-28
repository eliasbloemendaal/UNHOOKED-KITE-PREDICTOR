//
//  PersonalRatingViewController.swift
//  KITEGURU
//
//  Created by Elias Houttuijn Bloemendaal on 17-01-16.
//  Copyright © 2016 Elias Houttuijn Bloemendaal. All rights reserved.
//

import UIKit

class PersonalRatingViewController: UIViewController {
    
    // WeatherPredictions labels plus gear labels
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
    
    // Number labels plus advice labels
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
    
    // Segue met variable van de weatherPredictionViewController
    var city: String?
    var temp: Double?
    var desc: String?
    var icon: String?
    var speed: Double?
    var deg: Double?
    
    // Variables voor deze viewController
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
    var firstName: String?
    var functions = Functions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // http://stackoverflow.com/questions/26614395/swift-background-image-does-not-fit-showing-small-part-of-the-all-image
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "kiteBackSix")
        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        // http://stackoverflow.com/questions/17403483/set-title-of-back-bar-button-item-in-ios
        let btn = UIBarButtonItem(title: "Map", style: .Plain, target: self, action: "backBtnClicked")
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = btn
        
        // Als er geen plaats is opgezocht geef dan een waarden in plaat van nil en voorkom een error
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
    
        // Het verkrijgen van data van parse plus het rekenmodel van het KITEGURU advies
        let query = PFUser.query()
        query!.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId!)!) {
            (PFUser: PFObject?, error: NSError?) -> Void in
            if error == nil && PFUser != nil {
                print(PFUser)
                self.YourKiteLabel.text = self.functions.trimString(String(PFUser!["PersonalKites"]))
                self.yourWetsuitsLabel.text = self.functions.trimString(String(PFUser!["PersonalWetsuits"]))
                self.HoodImage.image = UIImage(named: self.functions.trimString(String(PFUser!["Hoods"])))
                self.BootsImage.image = UIImage(named: self.functions.trimString(String(PFUser!["Boots"])))
                self.GlovesImage.image = UIImage(named: self.functions.trimString(String(PFUser!["Gloves"])))
                self.YourWeightLabel.text = self.functions.trimString(String(PFUser!["Weight"]))
                self.firstName = self.functions.trimString(String(PFUser!["FirstName"]))
                self.navigationItem.title = self.firstName!
                var weightNumber = Double(self.functions.trimString(String(PFUser!["Weight"])))
                let knots = Double(self.speed!)
                self.kiteguruFinalAdvise = 8
                
                // Give a value before it errors
                if weightNumber == nil {
                    weightNumber = 80
                }

                // Rekenmodel, bepaalt het aantal vierkante meters van de kite
                if knots < 6 {
                    self.adviseKite = 0
                }
                else if knots >= 6 && knots < 8{
                    self.adviseKite = (((weightNumber!/knots) * 1.6) - 1)
                }
                else if knots >= 8 && knots <= 12{
                    self.adviseKite = (((weightNumber!/knots) * 1.8) - 1)
                }
                else if knots > 12 && knots <= 15{
                    self.adviseKite = (weightNumber!/knots) * 2.2
                }
                else if knots > 15 && knots <= 25{
                    self.adviseKite = (weightNumber!/knots) * 2.6
                }
                else if knots > 25{
                    self.adviseKite = (weightNumber!/knots) * 2.9
                }

                // Temperatuur van de zee ligt gemiddeld 4 graden onder de gemiddelde lucht temperatuur
                self.seaTemp = (self.temp!) - 4
                if self.temp! < 0 {
                    self.seaTemp = 2
                }
                
                // Rekenmodel, Bepaalt de dikte van het wetsuit en geeft op bepaalde plekker aftrek voor het niet hebben van gear
                if self.seaTemp < 6 {
                    self.adviseWetsuitThickness = 6
                    
                    //Aftrek voor het niet hebben van wetsuit Boots
                    if self.functions.trimString(String(PFUser!["Boots"])) == "redcross" {
                        self.kiteguruFinalAdvise! -= 2
                    }
                    
                    // Aftrek voor het niet hebben van een wetsuit hood
                    if self.functions.trimString(String(PFUser!["Hoods"])) == "redcross" {
                        self.kiteguruFinalAdvise! -= 1
                    }
                    
                    // Aftrek voor het niet hebben van wetsuit Gloves
                    if (self.functions.trimString(String(PFUser!["Gloves"]))) == "redcross" {
                        self.kiteguruFinalAdvise! -= 1
                    }
                }
                else if self.seaTemp >= 6 && self.seaTemp < 9 {
                    self.adviseWetsuitThickness = 5
                    
                    // Aftrek voor het niet hebben van Boots
                    if (self.functions.trimString(String(PFUser!["Boots"]))) == "redcross" {
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
                
                // Persoonlijke data verkregen van de wetsuits en in array gestopt
                var personalWetsuits = self.functions.trimString(String(PFUser!["PersonalWetsuits"]))
                
                // Give a value before it errors
                if Double(personalWetsuits) == nil {
                    personalWetsuits = "2-3"
                }
                let wetsuitString = self.functions.trimThaString(personalWetsuits)
                let arrayWetsuitString =  wetsuitString.characters.split {$0 == " "}.map(String.init)
                
                // Rekenmodel, Kijkt welke wetsuit het dichste bij het advies van de kite guru zit, waarde zijn absoluut
                for wetsuits in arrayWetsuitString {
                    let closestWetsuit = (Double(wetsuits)! - self.adviseWetsuitThickness!)
                    self.wetsuitArray.append(String(abs(closestWetsuit)))
                }
                
                // Pak de wetsuit die het dichste bij het KITEGURU advies zit
                let minimumWetsuit = self.wetsuitArray.minElement()
            
                // Wanneer de wetsuit dikte op het advies zit geen aftrek anders accumulatief
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
                
                // Persoonlijke data verkregen van de kite en in array gestopt
                var personalKites = self.functions.trimString(String(PFUser!["PersonalKites"]))
                
                // Give value before it errors
                if Double(personalKites) == nil {
                    personalKites = "10-8"
                }
                let personalKiteString = self.functions.trimThaString(personalKites)
                let personalKiteStringArray =  personalKiteString.characters.split {$0 == " "}.map(String.init)

                // Rekenmodel, Kijkt welke kite het dichste bij het advies van de kite guru zit, waardes zijn absoluut
                for kites in personalKiteStringArray {
                    let closestKite = (Double(kites)! - self.adviseKite!)
                    let closestRoundKites = round(closestKite)
                    self.kiteArray.append(abs(closestRoundKites))
                }

                // Pakt de kite die het dichste bij het KITEGURU advies zit
                let minimumKite = self.kiteArray.minElement()

                // Wanneer de kite op het advies zit geen aftrek anders accumulatief
                if Double(minimumKite!) == 0 {
                    print(self.kiteguruFinalAdvise!)
                }
                else if Double(minimumKite!) == 1 {
                    self.kiteguruFinalAdvise! -= 1
                }
                else if Double(minimumKite!) == 2 {
                    self.kiteguruFinalAdvise! -= 2
                }
                else if Double(minimumKite!) == 3 {
                    self.kiteguruFinalAdvise! -= 3
                }
                else if Double(minimumKite!) >= 4 {
                    self.kiteguruFinalAdvise! -= 5
                    if self.adviseKite == 0.0 {
                        self.kiteguruFinalAdvise = 1
                    }
                }
                
                // Als de gear goed is kan er een hoger advies worden uitgedeeld
                if self.kiteguruFinalAdvise == 8 && self.kiteguruFinalAdvise == 7 {
                    
                    // Als de zee temperatuur hoger is dan 25 graden een extra punt bij het kiteguru cijfer
                    if self.seaTemp >= 25{
                       self.kiteguruFinalAdvise! += 1
                    }
                    
                    // Als het mooi weer is, een extra punt bij het kiteguru cijfer
                    if self.description == "clear sky" {
                        self.kiteguruFinalAdvise! += 1
                    }
                }
                
                // Bij geen wind is het niet mogelijk om te gaan kiten
                if self.adviseKite == 0 {
                    self.kiteguruFinalAdvise! = 1
                }

                // Geef verschillende adviesen bij verschillende uitkomsten van het KITEGURU cijfer
                if self.kiteguruFinalAdvise == 0 {
                    self.oneLabel.text = "1"
                    self.finalLabel.text = "1"
                    self.oneLabel.textColor = UIColor.blueColor()
                    self.adviesLabel.text = self.functions.advise(1)
                }
                else if self.kiteguruFinalAdvise == 1 {
                    self.oneLabel.text = "1"
                    self.finalLabel.text = "1"
                    self.oneLabel.textColor = UIColor.blueColor()
                    self.adviesLabel.text = self.functions.advise(1)
                }
                else if self.kiteguruFinalAdvise == 2 {
                    self.twoLabel.text = "2"
                    self.finalLabel.text = "2"
                    self.twoLabel.textColor = UIColor.blueColor()
                    self.adviesLabel.text = self.functions.advise(2)
                }
                else if self.kiteguruFinalAdvise == 3 {
                    self.threeLabel.text = "3"
                    self.finalLabel.text = "3"
                    self.threeLabel.textColor = UIColor.blueColor()
                    self.adviesLabel.text = self.functions.advise(3)
                }
                else if self.kiteguruFinalAdvise == 4 {
                    self.fourLabel.text = "4"
                    self.finalLabel.text = "4"
                    self.fourLabel.textColor = UIColor.blueColor()
                    self.adviesLabel.text = self.functions.advise(4)
                }
                else if self.kiteguruFinalAdvise == 5 {
                    self.fiveLabel.text = "5"
                    self.finalLabel.text = "5"
                    self.fiveLabel.textColor = UIColor.blueColor()
                    self.adviesLabel.text = self.functions.advise(5)
                }
                else if self.kiteguruFinalAdvise == 6 {
                    self.sixLabel.text = "6"
                    self.finalLabel.text = "6"
                    self.sixLabel.textColor = UIColor.blueColor()
                    self.adviesLabel.text = self.functions.advise(6)
                }
                else if self.kiteguruFinalAdvise == 7 {
                    self.sevenLabel.text = "7"
                    self.finalLabel.text = "7"
                    self.sevenLabel.textColor = UIColor.blueColor()
                    self.adviesLabel.text = self.functions.advise(7)
                }
                else if self.kiteguruFinalAdvise == 8 {
                    self.eightLabel.text = "8"
                    self.finalLabel.text = "8"
                    self.eightLabel.textColor = UIColor.blueColor()
                    self.adviesLabel.text = self.functions.advise(8)
                }
                else if self.kiteguruFinalAdvise == 9 {
                    self.nineLabel.text = "9"
                    self.finalLabel.text = "9"
                    self.nineLabel.textColor = UIColor.blueColor()
                    self.adviesLabel.text = self.functions.advise(9)
                }
                else if self.kiteguruFinalAdvise == 10 {
                    self.tenLabel.text = "10"
                    self.finalLabel.text = "10"
                    self.tenLabel.textColor = UIColor.blueColor()
                    self.adviesLabel.text = self.functions.advise(10)
                }
            } else {
                print(error)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Ga verder naar de mail en neem een screenshot
    @IBAction func sendMail(sender: AnyObject) {
        functions.screenShotMethod()
        performSegueWithIdentifier("adviseToMail", sender: nil)
    }
    
    // Log out button, een ander user kan nu de app gebruiken
    @IBAction func LogOutButton(sender: AnyObject) {
        print("hij zit in de log out button")
        PFUser.logOut()
        let currentUser = PFUser.currentUser() // this will now be nil
        print(currentUser)
        performSegueWithIdentifier("logOutSignIn", sender: nil)
    }
    
    // Segue for de mailViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        // Segue with value to the mail viewController
        if (segue.identifier == "adviseToMail") {
            let svc = segue.destinationViewController as! MailViewController;
            svc.city = city
            svc.temp = temp
            svc.desc = desc
            svc.speed = speed
            svc.deg = deg
            svc.icon = icon
            svc.kiteguruFinalAdvise = kiteguruFinalAdvise
            svc.firstName = firstName
        }
    }

}

