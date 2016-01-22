//
//  signUp.swift
//  KITEGURU
//
//  Created by Elias Houttuijn Bloemendaal on 13-01-16.
//  Copyright © 2016 Elias Houttuijn Bloemendaal. All rights reserved.
//


class SignUp: NSObject {
    
    var firstName: String?
    var lastName: String?
    var userName: String?
    var userEmail: String?
    var password: String?
    var confirmPassword: String?
//    var kites: Array<String>?
//    var wetsuites: Array<String>?
    
    init(fName: String, lName: String, uName: String, email: String, pass: String, confirmPass: String){
        self.firstName = fName
        self.lastName = lName
        self.userName = uName
        self.userEmail = email
        self.password = pass
        self.confirmPassword = confirmPass
//        self.kites = kite
//        self.wetsuites = wetsuit
    }
//    
//    func signUpUser() throws -> Bool {
//        guard hasEmptyFields() else {
//            throw Error.emptyField
//        }
//        
//        guard isValidEmail() else {
//            throw Error.invalidEmail
//        }
//        
//        guard validatePasswordsMatch() else {
//            throw Error.passwordsDoNotMatch
//        }
//        
//        guard checkComplexityPassword() else {
//            throw Error.invalidPassword
//        }
//        
//        guard storeSuccesfullSignUp()  else {
//            throw Error.userNameTaken
//        }
//        
//        return true
//    }
//    
//    func hasEmptyFields () -> Bool {
//        if !firstName!.isEmpty && !lastName!.isEmpty && !userName!.isEmpty && !userEmail!.isEmpty && !confirmPassword!.isEmpty {
//            return true
//        }
//        return false
//    }
//    
//    func isValidEmail() -> Bool {
//        
//        let emailEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
//        let range = userEmail!.rangeOfString(emailEX, options:.RegularExpressionSearch)
//        let result = range != nil ? true : false
//        return result
//    }
//    
//    func validatePasswordsMatch() -> Bool {
//        if(password! == confirmPassword!){
//            return true
//        }
//        return false
//        
//    }
//    
//    func checkComplexityPassword () -> Bool {
//        let capitalLetterRegEx = ".*[A-Z]+.*"
//        let texTest = NSPredicate(format: "SELF MATCHES %@", capitalLetterRegEx)
//        let capitalResult = texTest.evaluateWithObject(password!)
//        print("Capital letter: \(capitalResult)")
//        
//        let numberRegEx = ".*[0-9]+.*"
//        let texTest2 = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
//        let numberResult = texTest2.evaluateWithObject(password!)
//        print("number included: \(numberResult)")
//        
//        let legthResult = password!.characters.count >= 8
//        print("password length = \(legthResult)")
//        
//        return capitalResult && numberResult && legthResult
//    }
//    
//    func storeSuccesfullSignUp() -> Bool {
//        
//        var succes = false
//        let user = PFUser()
//        
//        user["firstName"] = firstName!
//        user["lastName"] = lastName!
//        user.username = userName!
//        user.email = userEmail!
//        user.password = password!
//       
//        user.signUp()
//        
//        succes = user.isNew
//        
//        return succes
//        
//    }
    
    func checkAllRequirements() throws {
        
        // Check to make sure none of the text fields on our sign up view are empty //
        
        if firstName!.isEmpty && lastName!.isEmpty && userName!.isEmpty && userEmail!.isEmpty && password!.isEmpty && confirmPassword!.isEmpty {
            throw Error.emptyField
        }
        
        // Check for a valid email using a regular expression //
        
        let emailEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = userEmail!.rangeOfString(emailEX, options:.RegularExpressionSearch)
        let result = range != nil ? true : false
        
        if result == false {
            throw Error.invalidEmail
        }
        
        // Check to make sure both password entries are the same //
        
        if(password! != confirmPassword!) {
            throw Error.passwordsDoNotMatch
        }
        
        
        // Check for three password requirements //
        
        // check for capital letter
        let capitalLetterRegEx = ".*[A-Z]+.*"
        let textTest = NSPredicate(format: "SELF MATCHES %@", capitalLetterRegEx)
        let capitalResult = textTest.evaluateWithObject(password!)
        print("Capital letter: \(capitalResult)")
        
        // check for a number
        let numberRegEx = ".*[0-9]+.*"
        let textTest2 = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        let numberResult = textTest2.evaluateWithObject(password!)
        print("Number included: \(numberResult)")
        
        // check for 8 or more characters
        let lengthResult = password!.characters.count >= 8
        print("Passed length: \(lengthResult)")
        
        if !capitalResult && !numberResult && !lengthResult {
            throw Error.invalidPassword
        }
        
        
    }
    
    // store user in Parse database and create session as current user
    func saveUserAsync(completion:(result: PFUser?, success: Bool) -> Void)
    {
        let user = PFUser()     // initialize variable as PFUser
        
        user["FirstName"] = firstName!       //**
        user["LastName"] = lastName!        // user will take each field and add them to your object
        user.username = userName!          // Use PFUser pre made fields username, email, or password.
        user.email = userEmail!           // To create a custom field name use [""] to decalre the name.
        user.password = password!        //**
//        user["PersonalKites"] = kites!
//        user["PersonalWetsuits"] = wetsuites!
        
        user.signUpInBackgroundWithBlock({(success: Bool, error: NSError?) -> Void in
            
            if success {
                completion(result: PFUser.currentUser()!, success: true)
            } else {
                completion(result: nil, success: false)
            }
        })
        
    }
}



















 