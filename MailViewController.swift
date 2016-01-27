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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendMailButton(sender: AnyObject) {
        
//        let mailComposeViewController = configuredMailComposeViewController()
//        if MFMailComposeViewController.canSendMail() {
//            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
//        } else {
//            self.showSendMailErrorAlert()
//        }
//    }
    
        var SubjectText = "This is Elias: "
        SubjectText += subjectTextfield.text!
        
        let messageBody = bodyTextview
        
        let Recipients = ["elibloemendaal@gmail.com"]

        let mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
            mc.setSubject(SubjectText)
        mc.setMessageBody(messageBody.text, isHTML: false)
        mc.setToRecipients(Recipients)
        mc.addAttachmentData(UIImageJPEGRepresentation(UIImage(named: "redcross")!, CGFloat(1.0))!, mimeType: "image/jpeg", fileName:  "test.jpeg")
        
        self.presentViewController(mc, animated: true, completion: nil)
    }

//    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
//        switch result.rawValue{
//            
//        case MFMailComposeResultCancelled.rawValue:
//            NSLog("Mail Cancelled")
//        case MFMailComposeResultSaved.rawValue:
//            NSLog("Mail saved")
//        case MFMailComposeResultSent.rawValue:
//            NSLog("Mail Sent")
//        case MFMailComposeResultFailed.rawValue:
//            NSLog("Mail Sent Failure: %@",[error!.localizedDescription])
//        default:
//            break
//        }
//            
//        }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["someone@somewhere.com"])
        mailComposerVC.setSubject("Sending you an in-app e-mail...")
        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
        
        return mailComposerVC
    }
    
//    func showSendMailErrorAlert() {
//        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
//        sendMailErrorAlert.show()
//    }
        
    func showSendMailErrorAlert(){
        let alertview = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .Alert)
        alertview.addAction(UIAlertAction(title: "OK", style: .Default, handler:
            { (alertAction) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
        }))
        alertview.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(alertview, animated: true, completion: nil)
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func returnEmailStringBase64EncodedImage(image:UIImage) -> String {
        let imgData:NSData = UIImagePNGRepresentation(image)!;
        let dataString = imgData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        return dataString
    }
}



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


