//
//  MailViewController.swift
//  KITEGURU
//
//  Created by Elias Houttuijn Bloemendaal on 26-01-16.
//  Copyright © 2016 Elias Houttuijn Bloemendaal. All rights reserved.
//

import UIKit
import MessageUI

class MailViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var subjectTextfield: UITextField!
    @IBOutlet weak var bodyTextview: UITextView!
    
    // Segue for the mail from personalRatingViewController
    var city: String?
    var temp: Double?
    var desc: String?
    var icon: String?
    var speed: Double?
    var deg: Double?
    var kiteguruFinalAdvise: Int?
    var firstName: String?
    
    // Variable for the mail
    var tempString: String?
    var speedString: String?
    var degString: String?
    var functions = Functions()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Als er geen plaats is opgezocht geef dan een waarden in plaat van nil en voorkom een error
        if temp == nil || speed == nil || deg == nil || icon == nil || city == nil || kiteguruFinalAdvise == nil || desc == nil{
            temp = 0
            speed = 0
            deg = 0
            icon = "02n"
            city = " city "
            kiteguruFinalAdvise = 0
            desc = "weather mood"
        }
        
        // Rounding the numbers for in the mail
        tempString = String(format: "%.2f", temp!) + " Celsius"
        speedString = String(format: "%.2f", speed!) + " Knots"
        degString = String(format: "%.2f", deg!) + " Direction"
        
        // http://stackoverflow.com/questions/26614395/swift-background-image-does-not-fit-showing-small-part-of-the-all-image
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "kiteBackFour")
        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        // Het opgestelde mailtje met the weather predictions, het kiteguru advies plus cijfer.
        let messageBody = bodyTextview
        messageBody.text = "YO Dude, KITEGURU gave me an advise! \nThese are the weather conditions in \(city!), Temperature: \(tempString!), Weather mood: \(desc!), Windspeed: \(speedString!), Wind direction \(degString!) \nThis is the grade I got: \(kiteguruFinalAdvise!). This is my personal KITEGURU advice: \(functions.advise(kiteguruFinalAdvise!)). \nlet me know if you want to go! \nHANGLOOSEEE BROTHA!"
        
        // http://stackoverflow.com/questions/17403483/set-title-of-back-bar-button-item-in-ios
        // NavigationBar titles
        self.navigationItem.title = firstName!
        let btn = UIBarButtonItem(title: "Advice", style: .Plain, target: self, action: "backBtnClicked")
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = btn
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // De mail button zal een mailtje opstellen plus onderwerp plus een toegevoegde foto van KITEGURU
    @IBAction func sendMailButton(sender: AnyObject) {
        let messageBody = bodyTextview
        var SubjectText = "KITGURU - "
        let Recipients = ["elibloemendaal@gmail.com"]
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        SubjectText += subjectTextfield.text!
        mc.mailComposeDelegate = self
        mc.setSubject(SubjectText)
        mc.setMessageBody(messageBody.text, isHTML: false)
        mc.setToRecipients(Recipients)
        mc.addAttachmentData(UIImageJPEGRepresentation(UIImage(named: "kiteGuru.png")!, CGFloat(1.0))!, mimeType: "image/jpeg", fileName:  "test.jpeg")
        self.presentViewController(mc, animated: true, completion: nil)
    }

    // Geef een alert als de mail niet verzonden kan worden
    func showSendMailErrorAlert(){
        let alertview = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .Alert)
        alertview.addAction(UIAlertAction(title: "OK", style: .Default, handler:
            { (alertAction) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
        }))
        alertview.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(alertview, animated: true, completion: nil)
    }
    
    // De mail zal verdwijnen nadat de mail is verstuurd of gecanceled
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // De on screen keyboard zal verdwijnen wanner je buiten het keyboard klikt
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}


