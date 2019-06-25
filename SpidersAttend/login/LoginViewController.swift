//
//  LoginViewController.swift
//  SpidersAttend
//
//  Created by ddopik on 6/17/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import UIKit


class LoginViewController: BaseViewController {
    
    
    @IBOutlet weak var inputUserName: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        //
        //          _ = LoginViewController.generate(parent: self, messageText: "Network not available", messageTitle: "Network error", buttonText: "ok")
        
        
        
        
        /////
    }
    
    @IBAction func onLoginPressed(_ sender: Any) {
        
        
        
        do  {
            try startLocationServices()
            try isLoginInputsValid()
            requestLogin()
        }catch {
            
            _ = BaseViewController.generate(parent: self, messageText: (error as! ValidationError).message,messageTitle:  (error as! ValidationError).errorTitle, buttonText: "Ok")
        }
    }
    
    
    private func isLoginInputsValid() throws {
        

        
        if !Validator.validUserName(userName: self.inputUserName.text!){
            throw ValidationError("User name","invalid userName")
        }
        
        if !Validator.validatePassword(password : self.userPassword.text!){
            throw ValidationError("Password","invalid password")
            
        }
        
    }
    
    
    private  func requestLogin(){
        
//        APIClient.login(userName:userName, password:password) { result in
//            switch result {
//            case .success(let user):
//                print("_____________________________")
//                print(user)
//            case .failure(let error):
//                print(error)
//            }
//        }
       let loginParameter=[
        AppConstants.APIParameterKey.username : String( self.inputUserName.text!),
        AppConstants.APIParameterKey.pass :String(self.userPassword.text!),
        AppConstants.APIParameterKey.deviceID :String(UIDevice.current.identifierForVendor?.uuidString ?? "0000"),
        AppConstants.APIParameterKey.latitude :"3.3",
        AppConstants.APIParameterKey.longitude :"2.3"
        ] as [String : String]
        
        let successClos={ (a: LoginData) in
//            let x:String=a as! String
            print("suucess \(a.userData?.name)" )
        }
        
       let failureClos={
        (err:NetworkBaseError) in
//            print("failed ---->\(err.data?.msg)")
        }

        APIRouter.sendLoginRequest( loginparameters : loginParameter,success :successClos, failure : failureClos)
    }




}






