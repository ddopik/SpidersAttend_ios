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
     func onLocationUpdated(curenrtlocation:CLLocation)
    func onLocationFencingDetemined(state:CLRegionState)
}


class BaseViewController: UIViewController ,UITextViewDelegate {
    
    let locationManger = CLLocationManager()
    let progressView = UIView()
    var onLocationUpdateDelegate :OnLocationUpdateDelegate?
    var wrapTextViewList = [UITextView]()
    let textField = UITextField(frame: CGRect(x: 20.0, y:90.0, width: 280.0, height: 44.0))
    let languageDetails = LanguageDetails.getInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}
extension BaseViewController :CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let mLocation = locations.last else{
            return
        }
        print("lat -----locationManager--> \(mLocation.coordinate.latitude)")
        print("lng -----locationManager--> \(mLocation.coordinate.longitude) ")
        //        onLocationUpdateDelegate?.onLocationUpdated(curenrtlocation : locationManger.location!)
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        do{
            try   checkLocationAutorization()
        }catch{
            let errorObj = (error as! ValidationError)
            showSimpleConfirmDialog(parent: self , messageText: errorObj.message, messageTitle: errorObj.errorTitle, buttonText: "Ok")
            
            print( (error as! ValidationError).message )
        }
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region is CLCircularRegion {
            //            handleEvent(for: region)
            print(" user inside radious")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region is CLCircularRegion {
            //            handleEvent(for: region)
            print(" user outside radious")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("locationManager ---->monitoringDidFailFor(): \(error.localizedDescription)")
        //        print("Monitoring failed for region with identifier: \(region!.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        print("locationManager -----> didDetermineState() \(state.rawValue)")
        onLocationUpdateDelegate?.onLocationFencingDetemined (state:state)

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
            
            
            
            //        @unknown default:
            //            <#fatalError()#>
        }
        
    }
    
    private func startLocationUpdate() throws {
        if (locationManger.location?.coordinate) != nil{
            let lat=locationManger.location?.coordinate.latitude
            let lng=locationManger.location?.coordinate.longitude
            print("lat ---authorizedWhenInUse--> \(String(describing: lat))")
            print("lng ----authorizedWhenInUse-> \(String(describing: lng)) ")
            
            
            let Baselocation = CLLocation(latitude: 51.509986, longitude: -0.133787)// user's location
            let anotherLocation = CLLocation(latitude: lat!,longitude: lng!)
            let distance = Baselocation.distance(from: anotherLocation)
            print("distance is ----> \(distance)")

            onLocationUpdateDelegate?.onLocationUpdated(curenrtlocation : locationManger.location!)
            
 
            
        }else{
            throw ValidationError(message: "failed to get current location", errorTitle: "error")
            print("checkLocationAutorization ---> location is nil")
        }
        locationManger.startUpdatingLocation()
    }
    ////
    private func setUpLocationMangerServices(){
        locationManger.delegate=self
        locationManger.desiredAccuracy=kCLLocationAccuracyBest
    }
    
    func startLocationServices() throws{
        do{
            if(CLLocationManager.locationServicesEnabled()){
                // GPS is Enabled
                setUpLocationMangerServices()
                
                try  checkLocationAutorization()
                
            }else{
                _ =   showSimpleConfirmDialog(parent: self, messageText: "Please Allow Location services", messageTitle: "", buttonText: "Ok")
            }
        }catch{
            print("-------->\((error as! ValidationError).message)")
            _ = showSimpleConfirmDialog(parent: self, messageText: (error as! ValidationError).message, messageTitle:"", buttonText: "ok")
        }
        
    }
    
}


extension BaseViewController {
    
    public  func startProgress() {
        setupUnroundedIndeterminate()
        
        constrain(unroundedIndeterminate, leftView: thinFilledIndeterminate)
    }
    func setupUnroundedIndeterminate() {
        view.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(view).multipliedBy(0.4)
        }
    }
    
    func stopProgress(){
        progressView.removeFromSuperview()
    }
    
  
    private  func constrain(_ newView: UIView, leftView: UIView) {
        progressView.addSubview(newView)
        newView.snp.makeConstraints { (make) in
            make.size.equalTo(60)
            make.center.equalToSuperview()
            make.top.equalTo(265)
        }
    }
    fileprivate var unroundedIndeterminate: RPCircularProgress  {
        get {
            let progress = RPCircularProgress()
            progress.roundedCorners = false
            progress.thicknessRatio = 0.4
            progress.clockwiseProgress = false
            //        progress.trackTintColor = UIColor.blue
            //        progress.tintColor=UIColor.red
            progress.progressTintColor=UIColor.blue
            progress.enableIndeterminate()
            return progress
        }}
    fileprivate var thinFilledIndeterminate: RPCircularProgress   {
        get {
            let progress = RPCircularProgress()
            progress.innerTintColor = UIColor.red
            progress.thicknessRatio = 0.2
            progress.indeterminateDuration = 0.5
            return progress
        }}
    
}
/////////////////////////Set TextView to wrapContent
extension BaseViewController{
    
    func setWrapTextView(mTextView:UITextView){
        wrapTextViewList.append(mTextView)
        textViewDidChange(textView:mTextView)
    }
    
    func textViewDidChange(textView: UITextView)
    {
        let estimatedSize: CGSize = CGSize(width: view.frame.width, height: 20)
        
        for mTextView in wrapTextViewList{
            mTextView.isScrollEnabled = false
            
            let estimatedSize =  mTextView.sizeThatFits(estimatedSize)
            
            mTextView.constraints.forEach{ (constraints) in
                if constraints.firstAttribute == .height{
                    constraints.constant = estimatedSize.height
                }
            }
            
        }
    }
    
 
}
//////////////////////
extension BaseViewController {
    
    func getString(stringKey:String) -> String{
        return self.languageDetails.LocalString(key: stringKey)
    }
    
    
   
}
