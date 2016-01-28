//
//  BasicFunctions.swift
//  KITEGURU
//
//  Created by Elias Houttuijn Bloemendaal on 27-01-16.
//  Copyright © 2016 Elias Houttuijn Bloemendaal. All rights reserved.
//

import Foundation

class Functions{
    
    // Een functie die automatische een screenshot maakt
    func screenShotMethod() {
        let layer = UIApplication.sharedApplication().keyWindow!.layer
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIImageWriteToSavedPhotosAlbum(screenshot, nil, nil, nil)
    }
    
    // Trim een string tot een normaal te leze string
    func trimString(UntrimmedString: String) -> String {
        let text = String(UntrimmedString)
        let textWithoutNewLines = text.stringByReplacingOccurrencesOfString("\n", withString: "")
        let textWithoutLeftComma = textWithoutNewLines.stringByReplacingOccurrencesOfString("(", withString: "")
        let textWithoutRightComma = textWithoutLeftComma.stringByReplacingOccurrencesOfString(")", withString: "")
        let textWithoutSpace = textWithoutRightComma.stringByReplacingOccurrencesOfString(" ", withString: "")
        let textChanged = textWithoutSpace.stringByReplacingOccurrencesOfString(",", withString: "-")
        return textChanged
    }
    
    // Trim een string, om daarna in een array te plaatsen
    func trimThaString(UntrimmedString: String) -> String {
        let text = String(UntrimmedString)
        let textChanged = text.stringByReplacingOccurrencesOfString("-", withString: " ")
        return textChanged
    }
    
    // Een verschillende cijfers van de KITEGURU, geeft een verschillend advies
    func advise(input: Int) -> String{
        if input == 1 {
            return "Kiting is impossible"
        }else if input == 2 {
            return "Your Guru does not recommend kiting. Your equipment is not appropriate for the weather conditions"
        }else if input == 3 {
            return "Your Guru does not recommend kiting. Your equipment is not appropriate for the weather conditions"
        }else if input == 4 {
            return "Kiting is possible for advanced kite surfers only. Adjustments to your gear may be necessary"
        }else if input == 5 {
              return "Kiting is possible but tough for beginners. Advanced surfers may be able to withstand the weather conditions and enjoy themselves"
        }else if input == 6 {
            return "Your Guru recommends you to go kiting! The weather conditions and your gear are ok"
        }else if input == 7 {
            return "With your gear and in this weather it is definitely worthwhile to go kiting!"
        }else if input == 8 {
            return "Don’t hesitate: go kiting and have fun!"
        }else if input == 9 {
            return "All conditions are in place for a great kiting day!"
        }else if input == 10 {
            return "It’s your lucky day! The conditions could not be better. Your Guru wishes you a nice day!"
        }
        return "Error"
    }
    
    // Een functie die check of het textfield alleen maar cijfers bevat
    func containsOnlyNumbers(input: String) -> Bool {
        for char in input.characters {
            if (!(char >= "0" && char <= "9")) {
                return false
            }
        }
        return true
    }
    
    // Check of er maar 1 cijfer wordt gegeven (voor de wetsuits)
    func checkQuantityCharacters(input: String) -> Bool {
        if input.characters.count != 1 {
            return false
        }
        return true
    }
    
    // Check of het 2 of 3 karakters worden gegeven (voor het gewicht)
    func checkQuantityCharactersDos(input: String) -> Bool {
        if input.characters.count == 2 || input.characters.count == 3 {
            return false
        }
        return true
    }
    
    // Check of het 1 of 2 karakters (voor de kite)
    func checkQueantityCharactesrTwo(input: String) -> Bool {
        if input.characters.count > 0 && input.characters.count < 3 {
            return true
        }
        return false
    }
}