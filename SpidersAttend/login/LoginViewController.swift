//
//  LoginViewController.swift
//  SpidersAttend
//
//  Created by ddopik on 6/17/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import UIKit
import CoreLocation


class LoginViewController: BaseViewController,UITextFieldDelegate {
    
    
    
    @IBOutlet weak var inputUserName: UITextField!
    
    @IBOutlet weak var inputUserPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.onLocationUpdateDelegate = self
 
        self.inputUserName.delegate = self
//        inputUserName.returnKeyType = .done
        self.inputUserPassword.delegate = self
//        inputUserPassword.returnKeyType = .done
        
 
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        /////
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    @IBAction func onLoginPressed(_ sender: Any) {
        do  {
            try isLoginInputsValid()
            try startLocationServices()
            
            
        }catch {
            
            _ = showSimpleConfirmDialog(parent: self, messageText: (error as! ValidationError).message,messageTitle:  (error as! ValidationError).errorTitle, buttonText: "Ok")
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
        let successClos={ (loginResponse: LoginResponse?) in
            
            let loginData = loginResponse?.data
            ///
            PrefUtil.setIsFirstTimeLogin(  isFirstTime: false)
            PrefUtil.setIsLoggedIn(  isLoggedIn: true)
            PrefUtil.setUserToken(userToken: loginData?.userData?.token ?? "-1")
            PrefUtil.setUserID(  userId: loginData?.userData?.uid ?? "-1" )
            PrefUtil.setUserName(  userName: loginData?.userData?.name ?? " ")
            PrefUtil.setUserMail(  userMail: loginData?.userData?.email ?? " ")
            PrefUtil.setUserProfilePic(  profileImg: loginData?.userData?.img ?? " ")
            PrefUtil.setUserGender(  userGender: loginData?.userData?.gender ?? " ")
            PrefUtil.setUserTrackId( trackID: loginData?.userData?.track ?? " ")
            //            PrefUtil.setCurrentStatsMessage(  loginResponse.userData?.attendStatus?.msg!!)
            PrefUtil.setCurrentUserStatsID(  userStats: loginData?.attendStatus?.status ?? "-1")
            PrefUtil.setCurrentCentralLng(  currentCentralLng: loginData?.userData?.lng ?? "0.0")
            PrefUtil.setCurrentCentralLat(  currentCentralLat: loginData?.userData?.lat ?? "0.0")
            PrefUtil.setCurrentCentralRadius(  currentCentralRadious: loginData?.userData?.radius ?? "-1")
            //            /
            print("suucess \(String(describing: PrefUtil.getUserId()))" )
            super.stopProgress()
            NavigationManger(storyboard: self.storyboard!,viewController: self).navigateTo(target :Destinations.MainScreen)
         }
        let failureClos={
            (err:NetworkBaseError?) in
            print("failed ---->\(String(describing: err?.data?.msg))")
            _ = self.showSimpleConfirmDialog(parent: self, messageText: (err?.data?.msg) ?? "failed",messageTitle: "Error", buttonText: "Ok")
            super.stopProgress()
            
        }
        
//        APIRouter.sendLoginRequest( loginparameters : loginParameter,success : successClos , failure : failureClos)
        
        
        do {
            try APIRouter.makePostRequesr(url: APIRouter.LOGIN_URL, bodyParameters: loginParameter, succese: successClos, failure: failureClos, type: LoginResponse.self)
        }catch{
            let errorObj = error as! ValidationError
            showAlert(withTitle: errorObj.errorTitle, message: errorObj.message)
            self.stopProgress()
        }    }
    
   
    
}
extension LoginViewController:OnLocationUpdateDelegate{
    func onLocationUpdated(curenrtlocation: CLLocation) {
         requestLogin(curenrtlocation)
    }
    
    func onLocationFencingDetemined(state: CLRegionState) {
         
    }
    
    func onLocationFencingFailedDetemined(error: Error) {
        
    }
    
    func onLocationFencingInSide(enteredRegion: CLRegion) {
    }
    
    func onLocationFencingOutSide(OutedRegion: CLRegion) {
    }
    
}


extension LoginViewController{
    
 
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }

    // MARK: - Search Method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        textField.resignFirstResponder()
        return true
    }
}




