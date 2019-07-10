//
//  PrefUtil.swift
//  SpidersAttend
//
//  Created by ddopik on 6/25/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
class PrefUtil {
    
    
    private static let ARABIC_LANG = "ar"
    private static let ENGLISH_LANG = "en"
    private static let PREF_FILE_NAME = "AttendOnB"
    private static let APP_LANG = "APP_LNG"
    private static let USER_ID = "id"
    private static let  USER_TOKEN :String = "user_token"
    private static let USER_NAME = "user_name"
    private static let USER_TRACK = "user_track"
    private static let FIRST_TIME_LOGIN = "is_first_time_login"
    private static let IS_LOGGED_IN = "is_logged_in"
    private static let USER_MAIL = "user_mail"
    private static let PROFILE_PIC = "profile_pic"
    private static let USER_GENDER = "user_gender"
    private static let CURRENT_USER_STATS_ID = "current_user_stats"
    private static let CURRENT_STATS_MESSAGE = "current_stats_message"
    private static let CURRENT_CENTRAL_LAT = "current_central_lat"
    private static let CURRENT_CENTRAL_LNG = "current_central_lng"
    private static let CURRENT_CENTRAL_RADIOUS = "CURRENT_CENTRAL_RADIOUS"
    private static let IS_INSIDE_RADIOUS = "is_inside_radious"
    public static let savedItems = "saved GEO"

    
    
    
    static func setUserToken(userToken: String) {
        UserDefaults.standard.set(userToken, forKey: USER_TOKEN)
    }
    
    
    static func setUserID( userId: String) {
        UserDefaults.standard.set(userId, forKey: USER_ID)
        
    }
    
    static   func setUserName( userName: String) {
        UserDefaults.standard.set(userName, forKey: USER_NAME)
        
    }
    
    static func setUserTrackId(trackID: String) {
        UserDefaults.standard.set(trackID, forKey: USER_TRACK)
        
    }
    
    static func setIsFirstTimeLogin(isFirstTime: Bool) {
        UserDefaults.standard.set(isFirstTime, forKey: FIRST_TIME_LOGIN)
        
    }
    
    static func setIsLoggedIn(isLoggedIn: Bool) {
        UserDefaults.standard.set(isLoggedIn, forKey: IS_LOGGED_IN)
        
    }
    
    static func setUserMail(userMail: String) {
        UserDefaults.standard.set(userMail, forKey: USER_MAIL)
        
    }
    
    static func setUserProfilePic(profileImg: String) {
        
        UserDefaults.standard.set(profileImg, forKey: PROFILE_PIC)
        
    }
    
    static func setUserGender( userGender: String) {
        
        UserDefaults.standard.set(userGender, forKey: USER_GENDER)
    }
    
    static func setCurrentUserStatsID( userStats: String) {
        
        UserDefaults.standard.set(userStats, forKey: CURRENT_USER_STATS_ID)
        
        
    }
    
    //    static func setCurrentStatsMessage(context: Context, currentStatsMessage: String) {
    //        UserDefaults.standard.set(currentStatsMessage, forKey: CURRENT_STATS_MESSAGE)
    //    }
    
    static func setCurrentCentralLat( currentCentralLat: String) {
        UserDefaults.standard.set(currentCentralLat, forKey: CURRENT_CENTRAL_LAT)
        
    }
    
    static func setCurrentCentralLng( currentCentralLng: String) {
        UserDefaults.standard.set(currentCentralLng, forKey: CURRENT_CENTRAL_LNG)
    }
    
    
    static func setCurrentCentralRadius( currentCentralRadious: String) {
        
        UserDefaults.standard.set(currentCentralRadious, forKey: CURRENT_CENTRAL_RADIOUS)
        
    }
    
    //    static func setIsInsideRadius( isInsideRadius: Boolean) {
    //
    //        UserDefaults.standard.set(isInsideRadius, forKey: IS_INSIDE_RADIOUS)
    //    }
    //
    
    static func setAppLang(  appLang: String) {
        UserDefaults.standard.set(appLang, forKey: APP_LANG)
    }
    
    static  func getUseToken( ) -> String? {
        return  UserDefaults.standard.string(forKey: USER_TOKEN) ?? nil
    }
    
    static func getUserId() -> String? {
        return  UserDefaults.standard.string(forKey: USER_ID) ?? nil    }
    
    static func getUserName()->String? {
        return  UserDefaults.standard.string(forKey: USER_NAME) ?? nil
        
        
    }
    
    static func getUserTrack() -> String? {
        return  UserDefaults.standard.string(forKey: USER_TRACK) ?? nil
        
        
    }
    
    static func getUserMail() ->String? {
        return  UserDefaults.standard.string(forKey: USER_MAIL) ?? nil
    }
    
    static func getUserProfilePic()-> String? {
        return  UserDefaults.standard.string(forKey: PROFILE_PIC) ?? nil
    }
    
    static func getCurrentUserStatsID() -> String? {
        return  UserDefaults.standard.string(forKey: CURRENT_USER_STATS_ID) ?? nil
        
        
    }
    
    static func getUserGender( ) -> String? {
        return  UserDefaults.standard.string(forKey: USER_GENDER) ?? nil
    }
    
    //    static func getCurrentStatsMessage( ) -> String {
    //        return  UserDefaults.standard.string(forKey: CURRENT_STATS_MESSAGE)
    ////        return getSharedPref(mContext).getString(CURRENT_STATS_MESSAGE, "")
    //
    //    }
    
    static func getCurrentCentralLat( ) -> Double {
       
        return Double (UserDefaults.standard.string(forKey: CURRENT_CENTRAL_LAT) ?? "0.0" ) as! Double
    }
    static func getCurrentCentralLng( ) -> Double {
    
        return  Double (UserDefaults.standard.string(forKey: CURRENT_CENTRAL_LNG) ?? "0.0") as! Double
    }
    
  public  static func getCurrentCentralRadius() -> Double? {
 
    return Double(UserDefaults.standard.string(forKey: CURRENT_CENTRAL_RADIOUS) ?? "0.0" )
    }
    
    static func getAppLanguage( ) -> String? {
         return  UserDefaults.standard.string(forKey: APP_LANG) ?? ENGLISH_LANG

        
    }
    
//    static func isInsideRadius( ) -> bool? {
//         return  UserDefaults.standard.bool(forKey: IS_INSIDE_RADIOUS) ?? false
//    }
//
    static func isFirstTimeLogin( ) -> Bool {
         return  UserDefaults.standard.bool(forKey: FIRST_TIME_LOGIN) 

        
    }
    
    static func isLoggedIn( ) -> Bool {
        return  UserDefaults.standard.bool(forKey: IS_LOGGED_IN)

    }
    
    
    static func clearPrefUtil() {
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
    }
    
}



