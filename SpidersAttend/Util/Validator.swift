//
//  Validator.swift
//  SpidersAttend
//
//  Created by ddopik on 6/22/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
class Validator{
    
    
    static func validUserName(userName:String) -> Bool{
        if(userName.count == 0){
            return false
        }
            return true
    }
    
    static func validatedEmail(_ value: String) ->Bool {
        do {
            
            if  try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid e-mail Address","Email")
            }
        } catch{
            print("invalid mail ---> \(error)")
        }
        return true
    }
    
    
    static func validatePassword(password:String)->Bool{
        if(  password.count < 6  ){
            return false
            }
        return true
}
}
