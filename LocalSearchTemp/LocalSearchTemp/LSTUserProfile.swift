//
//  LSTUserProfile.swift
//  LocalSearchTemp
//
//  Created by Amit Gupta on 03/09/16.
//  Copyright © 2016 harman. All rights reserved.
//

import Foundation

class LSTUserProfile {
    
    var userName:String = ""
    var fullName:String = ""
    var firstName:String = ""
    var familyName:String = ""
    var age: Int = 0
    var email:String = ""
    var token:String = ""
    var cart: NSMutableArray!   =   NSMutableArray()
    var selectedFilters = NSMutableDictionary()
    
    
    
    class var sharedInstance :LSTUserProfile {
        struct Singleton {
            static let instance = LSTUserProfile()
        }
        
        return Singleton.instance
    }
}
