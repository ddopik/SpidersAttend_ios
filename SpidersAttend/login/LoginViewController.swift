//
//  LoginViewController.swift
//  SpidersAttend
//
//  Created by ddopik on 6/17/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import UIKit
import CoreLocation


class LoginViewController: BaseViewController {
    
    
    
    @IBOutlet weak var inputUserName: UITextField!
    
    @IBOutlet weak var inputUserPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.onLocationUpdateDelegate = self
        
        //
        //          _ = LoginViewController.generate(parent: self, messageText: "Network not available", messageTitle: "Network error", buttonText: "ok")
        
        
        
        
        /////
    }
    
    @IBAction func onLoginPressed(_ sender: Any) {
        do  {
            try isLoginInputsValid()
            try startLocationServices()
            
            
        }catch {
            
            _ = generate(parent: self, messageText: (error as! ValidationError).message,messageTitle:  (error as! ValidationError).errorTitle, buttonText: "Ok")
        }
    }
    
    
    private func isLoginInputsValid() throws {
        if !Validator.validUserName(userName: self.inputUserName.text!){
            throw ValidationError(message: "User name",errorTitle: "invalid userName")
        }
        
        if !Validator.validatePassword(password : self.inputUserPassword.text!){
            throw ValidationError(message: "Password",errorTitle: "invalid password")
            
        }        
    }
    
    
    private  func requestLogin(_ location: CLLocation){
        
        super.startProgress()
        let loginParameter=[
            AppConstants.APIParameterKey.username : String( self.inputUserName.text!),
            AppConstants.APIParameterKey.pass :String(self.inputUserPassword.text!),
            AppConstants.APIParameterKey.deviceID :String(UIDevice.current.identifierForVendor?.uuidString ?? "0000"),
            AppConstants.APIParameterKey.latitude  : String (location.coordinate.latitude),
            AppConstants.APIParameterKey.longitude :String (location.coordinate.longitude)
            ] as [String : String]
        //        dump(loginParameter)
        let successClos={ (loginResponse: LoginData?) in
            
            ///
            PrefUtil.setIsFirstTimeLogin(  isFirstTime: false)
            PrefUtil.setIsLoggedIn(  isLoggedIn: true)
            PrefUtil.setUserToken(userToken: loginResponse?.userData?.token ?? "-1")
            PrefUtil.setUserID(  userId: loginResponse?.userData?.uid ?? "-1" )
            PrefUtil.setUserName(  userName: loginResponse?.userData?.name ?? " ")
            PrefUtil.setUserMail(  userMail: loginResponse?.userData?.email ?? " ")
            PrefUtil.setUserProfilePic(  profileImg: loginResponse?.userData?.img ?? " ")
            PrefUtil.setUserGender(  userGender: loginResponse?.userData?.gender ?? " ")
            PrefUtil.setUserTrackId( trackID: loginResponse?.userData?.track ?? " ")
            //            PrefUtil.setCurrentStatsMessage(  loginResponse.userData?.attendStatus?.msg!!)
            PrefUtil.setCurrentUserStatsID(  userStats: loginResponse?.attendStatus?.status ?? "-1")
            PrefUtil.setCurrentCentralLng(  currentCentralLng: loginResponse?.userData?.lng ?? "0.0")
            PrefUtil.setCurrentCentralLat(  currentCentralLat: loginResponse?.userData?.lat ?? "0.0")
            PrefUtil.setCurrentCentralRadius(  currentCentralRadious: loginResponse?.userData?.radius ?? "-1")
            //            /
            print("suucess \(String(describing: PrefUtil.getUserId()))" )
            super.stopProgress()
            
            self.navigateToMainStateScreen()
        }
        let failureClos={
            (err:NetworkBaseError?) in
            print("failed ---->\(String(describing: err?.data?.msg))")
            _ = self.generate(parent: self, messageText: (err?.data?.msg) ?? "failed",messageTitle: "Error", buttonText: "Ok")
            super.stopProgress()
            
        }
        
        APIRouter.sendLoginRequest( loginparameters : loginParameter,success : successClos , failure : failureClos)
    }
    
    func navigateToMainStateScreen(){
        let mainStateTabNavigationController =  self.storyboard!.instantiateViewController(withIdentifier: "MainTabViewController") as! UITabBarController
        self.present(mainStateTabNavigationController, animated: true, completion: nil)
    }
    
}
extension LoginViewController:OnLocationUpdateDelegate{
    func onLocationFencingDetemined(state: CLRegionState) {
        return
    }
    
    func onLocationUpdated(curenrtlocation location: CLLocation) {
        requestLogin(location)
    }
    
    
}






