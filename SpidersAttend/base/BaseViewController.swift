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
    func onLocationUpdateFailed(error:Error)
    // Active this Bloc in case want to listen for Fencing updates Of cource after register you location 
//    func onLocationFencingDetemined(state:CLRegionState) // instant fencing Request State
//    func onLocationFencingInSide(enteredRegion: CLRegion) // litener work with startMonitoring(region)
//    func onLocationFencingOutSide(OutedRegion: CLRegion) // litener work with startMonitoring(region)
//    func onLocationFencingFailedDetemined(error:Error)
    
}


class BaseViewController: UIViewController ,UITextViewDelegate {
    
    var locationManger = CLLocationManager()
    let progressView = UIView()
    // intialized by subViewController
    var onLocationUpdateDelegate :OnLocationUpdateDelegate?
    var wrapTextViewList = [UITextView]()
    let textField = UITextField(frame: CGRect(x: 20.0, y:90.0, width: 280.0, height: 44.0))
    let languageDetails = LanguageDetails.getInstance
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManger.delegate = self
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
    
        //please note to stop navigationManger with  stopLocationManger() if locationUpdate Not required

        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        do{
            try   checkLocationAutorization()
        }catch{
            onLocationUpdateDelegate?.onLocationUpdateFailed(error: error)
            print( (error as! ValidationError).message )
        }
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region is CLCircularRegion {
//            onLocationUpdateDelegate?.onLocationFencingInSide(enteredRegion: region)
            print(" user inside radious")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region is CLCircularRegion {
//            onLocationUpdateDelegate?.onLocationFencingOutSide(OutedRegion: region)
            print(" user outside radious")
        }
    }
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        print("locationManager -----> didDetermineState() \(state.rawValue)")
//        onLocationUpdateDelegate?.onLocationFencingDetemined (state:state)
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("locationManager ---->monitoringDidFailFor(): \(error.localizedDescription)")
//        onLocationUpdateDelegate?.onLocationFencingFailedDetemined (error: error)
        //        print("Monitoring failed for region with identifier: \(region!.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManager ---->didFailWithError(): \(error.localizedDescription)")
        onLocationUpdateDelegate?.onLocationUpdateFailed(error: error)
        
    }
    func stopLocationManger(){
        self.locationManger.stopUpdatingLocation()
        
    }
}
extension BaseViewController
{
    
    /*
     location permated and allwaed to get current location if already intialized
     as we can't depand on Location updater delegate in case user cuurentlly did't move
     */
    private func startLocationUpdate() throws {
        do{
            try  checkLocationAutorization()
            locationManger.startUpdatingLocation()
        }catch{
            onLocationUpdateDelegate?.onLocationUpdateFailed(error: error)
            print( (error as! ValidationError).message )
        }
    }
    
    
    func startLocationServices() throws{
        do{
            if(CLLocationManager.locationServicesEnabled()){
                // GPS is Enabled
                setUpLocationMangerServices()
                try  startLocationUpdate()
            }else{
                throw (ValidationError(message: "Please Allow Location services", errorTitle:""))
            }
        }catch{
            print("BaseViewController -------->\((error as! ValidationError).message)")
            throw (error)
        }
        //////////////////////
    }
    private func setUpLocationMangerServices(){
        locationManger.delegate=self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
    }
    private func checkLocationAutorization() throws{
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            break
        case .authorizedWhenInUse :
            //             already got our desired permuation
            break
        case .denied :
            // promote A dialog the we need permuation
            print("locationManger ---> denied")
            throw ValidationError(message: "Permation",errorTitle: "Please allow Location services")
        case .restricted :
            break
        case .notDetermined:
            locationManger.requestWhenInUseAuthorization()
                throw ValidationError(message: "Permation",errorTitle: "Please allow Location services")
            print("locationManger ---> notDetermined")
            break
            
        }
        
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
extension UITabBar {
    func setBadge(value: String?, at index: Int, withConfiguration configuration: TabBarBadgeConfiguration = TabBarBadgeConfiguration()) {
        let existingBadge = subviews.first { ($0 as? TabBarBadge)?.hasIdentifier(for: index) == true }
        existingBadge?.removeFromSuperview()
        
        guard let tabBarItems = items,
            let value = value else { return }
        
        let itemPosition = CGFloat(index + 1)
        let itemWidth = frame.width / CGFloat(tabBarItems.count)
        let itemHeight = frame.height
        
        let badge = TabBarBadge(for: index)
        badge.frame.size = configuration.size
        badge.center = CGPoint(x: (itemWidth * itemPosition) - (0.5 * itemWidth) + configuration.centerOffset.x,
                               y: (0.5 * itemHeight) + configuration.centerOffset.y)
        badge.layer.cornerRadius = 0.5 * configuration.size.height
        badge.clipsToBounds = true
        badge.textAlignment = .center
        badge.backgroundColor = configuration.backgroundColor
        badge.font = configuration.font
        badge.textColor = configuration.textColor
        badge.text = value
        
        addSubview(badge)
    }
}

class TabBarBadge: UILabel {
    var identifier: String = String(describing: TabBarBadge.self)
    
    private func identifier(for index: Int) -> String {
        return "\(String(describing: TabBarBadge.self))-\(index)"
    }
    
    convenience init(for index: Int) {
        self.init()
        identifier = identifier(for: index)
    }
    
    func hasIdentifier(for index: Int) -> Bool {
        let has = identifier == identifier(for: index)
        return has
    }
}

class TabBarBadgeConfiguration {
    var backgroundColor: UIColor = .red
    var centerOffset: CGPoint = .init(x: 0, y: -9)
    var size: CGSize = .init(width: 40, height: 17)
    var textColor: UIColor = .white
    var font: UIFont! = .systemFont(ofSize: 6) {
        didSet { font = font ?? .systemFont(ofSize: 6) }
    }
    
    static func construct(_ block: (TabBarBadgeConfiguration) -> Void) -> TabBarBadgeConfiguration {
        let new = TabBarBadgeConfiguration()
        block(new)
        return new
    }
}
