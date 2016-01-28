//
//  Enums.swift
//  KITEGURU
//
//  Created by Elias Houttuijn Bloemendaal on 13-01-16.
//  Copyright © 2016 Elias Houttuijn Bloemendaal. All rights reserved.
//

// https://github.com/kevincaughman/Resume-App/tree/master/Models
enum Error: ErrorType {
    case emptyField
    case passwordsDoNotMatch
    case invalidEmail
    case userNameTaken
    case incorrectSignIn
    case invalidPassword
}

// With every error the another text will appaer
extension Error: CustomStringConvertible {
    var description: String {
        switch self {
        case .emptyField: return "Please fill in all the fields"
        case .passwordsDoNotMatch: return "Passsword do not match"
        case .invalidEmail: return "Please fill in an valid email"
        case .userNameTaken: return "The username or password is already taken"
        case .incorrectSignIn: return "The username or password is incorrect"
        case .invalidPassword: return "Password must be at least 8 characters long, \n and include a numeric and a capital letter"
        }
    }
}
