//
//  GeotificationBaseViewController.swift
//  SpidersAttend
//
//  Created by ddopik on 6/27/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit


protocol OnLocationFencingUpdate {
    func onDestanceGetMeasured(destance :Double)
    func onUserInside()
    func onUserOutside()
    func onUserWithUnKnowenFencing()
    func onUserWithUnErrorFencing(error:Error)
}



class GeotificationBaseViewController : BaseViewController{
    var allGeotifications:[Geotification] = []
    var locationManager = CLLocationManager()
 // this var called by locationManagerDelegate
// then get passed to Any subViewController through OnLocationFencingUpdate Delegate
    var onLocationFencingUpdate :OnLocationFencingUpdate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.onLocationUpdateDelegate = self

    }
    
    
    func startGeotiFication(_ lat:Double,_ lng:Double) {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        //           loadAllGeotifications() ///load old fencing region
        let identifier = NSUUID().uuidString
        let note = "UserFencing"
        let eventType: Geotification.EventType = .onExit
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude:lng)
        // 1
        //
        let clampedRadius = min(PrefUtil.getCurrentCentralRadius()!, locationManager.maximumRegionMonitoringDistance)
        
        let geotification = Geotification(coordinate: coordinate, radius: clampedRadius,
                                          identifier: identifier, note: note, eventType: eventType)
        
        // in case allawing multible fencing we add the new insert new  point
        //         add(geotification)
        //        saveAllGeotifications()
        ////////
        discardMonitoringAllRegion()
        startMonitoring(geotification: geotification)
    }
    
    
    // MARK: Loading and saving functions
    private  func loadAllGeotifications() {
        allGeotifications.removeAll()
        let allGeotifications = Geotification.allGeotifications()
        allGeotifications.forEach { add($0) }
    }
    
    
    private   func saveAllGeotifications() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(allGeotifications)
            UserDefaults.standard.set(data, forKey: PrefUtil.savedItems)
        } catch {
            print("error encoding geotifications")
        }
    }
    
    
    // MARK: Functions that update the model/associated views with geotification changes
    private  func add(_ geotification: Geotification) {
        allGeotifications.append(geotification)
    }
    
    private    func remove(_ geotification: Geotification) {
        guard let index = allGeotifications.firstIndex(of: geotification) else { return }
        allGeotifications.remove(at: index)
    }
    
    /***   With the location manager properly configured, you must now allow your app to register user geofences for monitoring.
     //    Your app stores the user geofence information within your custom Geotification model. However, to monitor geofences, Core Location requires you to represent each one as a CLCircularRegion instance. To handle this requirement, you’ll create a helper method that returns a CLCircularRegion from a given Geotification object.
     ***/
    private    func region(with geotification: Geotification) -> CLCircularRegion {
        let region = CLCircularRegion(center: geotification.coordinate,
                                      radius: geotification.radius,
                                      identifier: geotification.identifier)
        
        region.notifyOnEntry = true
        region.notifyOnExit = true
        return region
    }
    
    func startMonitoring(geotification: Geotification) {
        if !CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            showAlert(withTitle:"Error", message: "Geofencing is not supported on this device!")
            return
        }
        let fenceRegion = region(with: geotification)
        locationManager.startMonitoring(for: fenceRegion)
        locationManager.requestState(for: fenceRegion)
    }
    
    func stopMonitoring(geotification: Geotification) {
        for region in locationManager.monitoredRegions {
            guard let circularRegion = region as? CLCircularRegion, circularRegion.identifier == geotification.identifier else {
                continue
            }
            
            locationManager.stopMonitoring(for: circularRegion)
        }
    }
    
    private   func discardMonitoringAllRegion(){
        let monitoredRegions = locationManager.monitoredRegions
        
        for region in monitoredRegions{
            locationManager.stopMonitoring(for: region)
        }
    }
    
}





extension GeotificationBaseViewController : OnLocationUpdateDelegate{
 
    
    func onLocationUpdated(curenrtlocation: CLLocation) {
        let newLocation = curenrtlocation
        //The last location must not be capured more then 3 seconds ago
        print( " horizontalAccuracy \(curenrtlocation.horizontalAccuracy )" )
        let centralLat = PrefUtil.getCurrentCentralLat()
        let centralLng = PrefUtil.getCurrentCentralLng()
        let centrallocation = CLLocation(latitude: centralLat, longitude: centralLng)
        let anotherLocation = CLLocation(latitude: newLocation.coordinate.latitude,longitude: newLocation.coordinate.longitude)
        let distance = centrallocation.distance(from: anotherLocation)        
        self.onLocationFencingUpdate?.onDestanceGetMeasured(destance: distance)
    }
    
    
    
    //// case requestState() in user
    func onLocationFencingDetemined(state: CLRegionState) {
        switch state {
        case .inside :
            onLocationFencingUpdate?.onUserInside()
            break
        case .outside :
            onLocationFencingUpdate?.onUserOutside()
            break
        case .unknown :
            onLocationFencingUpdate?.onUserWithUnKnowenFencing()
            break
        default:
            onLocationFencingUpdate?.onUserWithUnKnowenFencing()
            print("User default Fencing")
        }
    }
    
    
    
    
    //StartMonitor() method
    func onLocationFencingInSide(enteredRegion: CLRegion){
        print("User Inside")
        onLocationFencingUpdate?.onUserInside()
    }
    //StartMonitor() method
    func onLocationFencingOutSide(OutedRegion: CLRegion) {
        print("User outSide")
        onLocationFencingUpdate?.onUserOutside()
    }
    
     func onLocationFencingFailedDetemined(error: Error) {
        onLocationFencingUpdate?.onUserWithUnKnowenFencing()
        print("User Unknowen Fencing")
    }
    /**
     called when geoFemcing requestState() failed
     */
   func onUserWithUnErrorFencing(error:Error){
        print("MainStateViewController------>onLocationFencingFailedDetemined()  \(error.localizedDescription) ")
        onLocationFencingUpdate?.onUserWithUnErrorFencing(error: error)
        
        
    }
}





//startGeotiFication(  PrefUtil.getCurrentCentralLat(),PrefUtil.getCurrentCentralLng() )
