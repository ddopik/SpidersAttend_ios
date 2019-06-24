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

class BaseViewController: UIViewController {
    
    let locationManger = CLLocationManager()
    let container = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
}


extension BaseViewController :CLLocationManagerDelegate{
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else{
            return
            
        }
        print("lat ---> \(currentLocation.coordinate.latitude)")
        print("lng---> \(currentLocation.coordinate.longitude) ")
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        do{
            try   checkLocationAutorization()
        }catch{
            print("Please allow permation")
        }
      
    }
    
    private func checkLocationAutorization() throws{
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse :
            //             already got our desired permuation
            if (locationManger.location?.coordinate) != nil{
                let lat=locationManger.location?.coordinate.longitude
                let lng=locationManger.location?.coordinate.longitude
                
                print("lat ---> \(String(describing: lat))")
                print("lng---> \(String(describing: lng)) ")
                
            }else{
                print("checkLocationAutorization ---> location is nil")
            }
            locationManger.startUpdatingLocation()
            
            break
        case .denied :
            // promote A dialog the we need permuation
             throw ValidationError("Permation","Please allow Location services")
            
        case .restricted :
            break
        case .notDetermined:
            locationManger.requestWhenInUseAuthorization()
           
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
            _ = BaseViewController.generate(parent: self, messageText: "A Message", messageTitle: "A title", buttonText: "A button label")
        }
        }catch{
                  _ = BaseViewController.generate(parent: self, messageText: "", messageTitle: "Please allow location permation", buttonText: "ok")
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
extension BaseViewController{
    class func generate(parent: UIViewController, messageText: String, messageTitle: String, buttonText: String) -> UIAlertController {
        let alert = UIAlertController(title: messageTitle, message: messageText, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonText, style: UIAlertAction.Style.default, handler: nil))
        parent.present(alert, animated: true, completion: nil)
        return alert
    }
}
