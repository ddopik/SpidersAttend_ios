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


public protocol OnLocationUpdateDelegate {
    func onLocationUpdated(curenrtlocation:CLLocation)
}


class BaseViewController: UIViewController {
    
    let locationManger = CLLocationManager()
    let container = UIView()
    var onLocationUpdateDelegate :OnLocationUpdateDelegate?
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
            print("Please allow permation")
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
        
    }
}
extension BaseViewController
{
    private func checkLocationAutorization() throws{
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            //             already got our desired permuation
            if (locationManger.location?.coordinate) != nil{
                let lat=locationManger.location?.coordinate.longitude
                let lng=locationManger.location?.coordinate.longitude
                print("lat ---authorizedAlways--> \(String(describing: lat))")
                print("lng ----authorizedAlways-> \(String(describing: lng)) ")
                
                onLocationUpdateDelegate?.onLocationUpdated(curenrtlocation : locationManger.location!)
                
            }else{
                print("checkLocationAutorization ---> location is nil")
            }
            locationManger.startUpdatingLocation()
            break
        case .authorizedWhenInUse :
            //             already got our desired permuation
            if (locationManger.location?.coordinate) != nil{
                let lat=locationManger.location?.coordinate.longitude
                let lng=locationManger.location?.coordinate.longitude
                print("lat ---authorizedWhenInUse--> \(String(describing: lat))")
                print("lng ----authorizedWhenInUse-> \(String(describing: lng)) ")
                
                onLocationUpdateDelegate?.onLocationUpdated(curenrtlocation : locationManger.location!)
                
            }else{
                print("checkLocationAutorization ---> location is nil")
            }
            locationManger.startUpdatingLocation()
            
            break
        case .denied :
            // promote A dialog the we need permuation
            print("locationManger ---> denied")
            throw ValidationError("Permation","Please allow Location services")
            
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
              _ =   generate(parent: self, messageText: "A Message", messageTitle: "A title", buttonText: "A button label")
            }
        }catch{
           _ = generate(parent: self, messageText: "", messageTitle: "Please allow location permation", buttonText: "ok")
        }
    }
    
}


extension BaseViewController {
    func setupContainer() {
        view.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(view).multipliedBy(0.4)
        }
    }
    
    func setupUnroundedIndeterminate() {
        setupContainer()
        
        constrain(unroundedIndeterminate, leftView: thinFilledIndeterminate)
    }
    func constrain(_ newView: UIView, leftView: UIView) {
        container.addSubview(newView)
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
//extension BaseViewController{
//    class func generate(parent: UIViewController, messageText: String, messageTitle: String, buttonText: String) -> UIAlertController {
//        let alert = UIAlertController(title: messageTitle, message: messageText, preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: buttonText, style: UIAlertAction.Style.default, handler: nil))
//        parent.present(alert, animated: true, completion: nil)
//        return alert
//    }
//    
//}

