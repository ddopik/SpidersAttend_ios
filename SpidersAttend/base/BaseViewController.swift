//
//  ViewController.swift
//  SpidersAttend
//
//  Created by ddopik on 6/15/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import UIKit
import CoreLocation
import SnapKit
import MapKit


  protocol OnLocationUpdateDelegate {
    func onLocationUpdated(curenrtlocation:CLLocation) /// this method get user in Child viewController
    func onLocationFencingDetemined(state:CLRegionState) // instant fencing Request State
    func onLocationFencingInSide(enteredRegion: CLRegion) // litener work with startMonitoring(region)
    func onLocationFencingOutSide(OutedRegion: CLRegion) // litener work with startMonitoring(region)
    func onLocationFencingFailedDetemined(error:Error)
}


class BaseViewController: UIViewController ,UITextViewDelegate {
    
    var locationManger = CLLocationManager()
    let progressView = UIView()
    var onLocationUpdateDelegate :OnLocationUpdateDelegate?
    var wrapTextViewList = [UITextView]()
    let textField = UITextField(frame: CGRect(x: 20.0, y:90.0, width: 280.0, height: 44.0))
    let languageDetails = LanguageDetails.getInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUnroundedIndeterminate()
        constrain(unroundedIndeterminate, leftView: thinFilledIndeterminate)
        // Do any additional setup after loading the view.
    }
    
    
  
}
extension BaseViewController :CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mLocation = locations.last else{
            return
        }
        self.locationManger = manager
        print("lat -----locationManager--> \(mLocation.coordinate.latitude)")
        print("lng -----locationManager--> \(mLocation.coordinate.longitude) ")
         onLocationUpdateDelegate?.onLocationUpdated(curenrtlocation : locationManger.location!)
         stopLocationManger()

    }
    

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        do{
            try   checkLocationAutorization()
        }catch{
            let errorObj = (error as! ValidationError)
            _ =  showSimpleConfirmDialog(parent: self , messageText: errorObj.message, messageTitle: errorObj.errorTitle, buttonText: "Ok")
            print( (error as! ValidationError).message )
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region is CLCircularRegion {
         onLocationUpdateDelegate?.onLocationFencingInSide(enteredRegion: region)
             print(" user inside radious")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region is CLCircularRegion {
            onLocationUpdateDelegate?.onLocationFencingOutSide(OutedRegion: region)
             print(" user outside radious")
        }
    }
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        print("locationManager -----> didDetermineState() \(state.rawValue)")
        onLocationUpdateDelegate?.onLocationFencingDetemined (state:state)
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("locationManager ---->monitoringDidFailFor(): \(error.localizedDescription)")
        onLocationUpdateDelegate?.onLocationFencingFailedDetemined (error: error)
        //        print("Monitoring failed for region with identifier: \(region!.identifier)")
    }
    

    
    func stopLocationManger(){
        self.locationManger.stopUpdatingLocation()

    }
}
extension BaseViewController
{
    private func checkLocationAutorization() throws{
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
           try startLocationUpdate()
            break
        case .authorizedWhenInUse :
            //             already got our desired permuation
          try  startLocationUpdate()
            break
        case .denied :
            // promote A dialog the we need permuation
            print("locationManger ---> denied")
            throw ValidationError(message: "Permation",errorTitle: "Please allow Location services")
        case .restricted :
            break
        case .notDetermined:
            locationManger.requestWhenInUseAuthorization()
            print("locationManger ---> notDetermined")
            break
            
        }
        
    }
    /*
     location permated and allwaed to get current location if already intialized
     as we can't depand on Location updater delegate in case user cuurentlly did't move
     */
    private func startLocationUpdate() throws {
 
        if (locationManger.location?.coordinate) != nil{
            onLocationUpdateDelegate?.onLocationUpdated(curenrtlocation : locationManger.location!)
            return
        }else{
            locationManger.startUpdatingLocation()
            throw ValidationError(message: "failed to get current location", errorTitle: "error")
         }
    }
 
    private func setUpLocationMangerServices(){
        locationManger.delegate=self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
      }
    
    func startLocationServices() throws{
        do{
            if(CLLocationManager.locationServicesEnabled()){
                // GPS is Enabled
                setUpLocationMangerServices()
                
                try  checkLocationAutorization()
                /////////////////// those confirm dialog should be in
            }else{
                _ =   showSimpleConfirmDialog(parent: self, messageText: "Please Allow Location services", messageTitle: "", buttonText: "Ok")
                throw (ValidationError(message: "Please Allow Location services", errorTitle:""))

            }
        }catch{
            print("-------->\((error as! ValidationError).message)")
            _ = showSimpleConfirmDialog(parent: self, messageText: (error as! ValidationError).message, messageTitle:"", buttonText: "ok")
            throw (error)
        }
        //////////////////////
    }
    
}


/////////////////////////Set TextView to wrapContent
extension BaseViewController{
    
    func setWrapTextView(mTextView:UITextView){
        wrapTextViewList.append(mTextView)
        textViewDidChange(textView:mTextView)
    }

    // Floaty method
    func textViewDidChange(textView: UITextView)
    {
//        let estimatedSize: CGSize = CGSize(width: view.frame.width, height: 20)
//
//        for mTextView in wrapTextViewList{
//            mTextView.isScrollEnabled = false
//
//            let estimatedSize =  mTextView.sizeThatFits(estimatedSize)
//
//            mTextView.constraints.forEach{ (constraints) in
//                if constraints.firstAttribute == .height{
//                    constraints.constant = estimatedSize.height
//                }
//            }
//
//        }
    }
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
 
}
//////////////////////
extension BaseViewController {
    
    func getString(stringKey:String) -> String{
        
      return  NSLocalizedString(stringKey,
                          comment:stringKey)
//        return self.languageDetails.LocalString(key: stringKey)
    }
    
    
   
}
