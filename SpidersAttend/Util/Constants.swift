//
//  Constants.swift
//  Networking
//


import Foundation
import UIKit


let MANAGMENT_PENDING_VACATION_MANAGMENT_CONTROLLER = "0"
let MANAGMENT_PENDING_VACATION_MANAGMENT_UN_CONTROLLER = "1"

struct ApiConstant {
    
    
 
    static let ENTER="1"
    static let OUT="2"
    static let ENDED="3"
    
 

    
//    static let QR_SCANNER_CONSTANT="https://hr-arabjet.spiderholidays.co/en/"
    static let QR_SCANNER_CONSTANT="https://nfc.spiderholidays.co/en/"

    
    
    
    
    struct APIParameterKey {
        static let username = "username"
        static let pass = "pass"
        static let imei = "imei"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let deviceID="imei"
    }
    

}

struct FONTS {
    static let MAIN_TAB_BAR_FONT_SIZE: CGFloat = 14.0
}


enum NavigationType {
    case HOME,QRReader, Network,Vacation,PayRoll
}
enum AttendMethod {
    case QR,NETWORK
}
