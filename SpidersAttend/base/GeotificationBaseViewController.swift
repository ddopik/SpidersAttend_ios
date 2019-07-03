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

class GeotificationBaseViewController : BaseViewController{
    var allGeotifications:[Geotification] = [] 
    var locationManager = CLLocationManager()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
     
    }
    
    
    func startGeotiFication(_ lat:Double,_ lng:Double){
        
        
        
      
        
        
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
        startMonitoring(geotification: geotification)
    }
    
    
    // MARK: Loading and saving functions
    func loadAllGeotifications() {
        allGeotifications.removeAll()
        let allGeotifications = Geotification.allGeotifications()
        allGeotifications.forEach { add($0) }
    }
    
    
    func saveAllGeotifications() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(allGeotifications)
            UserDefaults.standard.set(data, forKey: PrefUtil.savedItems)
        } catch {
            print("error encoding geotifications")
        }
    }
    
 
    // MARK: Functions that update the model/associated views with geotification changes
    func add(_ geotification: Geotification) {
        allGeotifications.append(geotification)
    }
    
    func remove(_ geotification: Geotification) {
        guard let index = allGeotifications.firstIndex(of: geotification) else { return }
        allGeotifications.remove(at: index)
    }
    
    /***   With the location manager properly configured, you must now allow your app to register user geofences for monitoring.
     //    Your app stores the user geofence information within your custom Geotification model. However, to monitor geofences, Core Location requires you to represent each one as a CLCircularRegion instance. To handle this requirement, you’ll create a helper method that returns a CLCircularRegion from a given Geotification object.
     ***/
    func region(with geotification: Geotification) -> CLCircularRegion {
        // 1
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
            guard let circularRegion = region as? CLCircularRegion, circularRegion.identifier == geotification.identifier else { continue }
            locationManager.stopMonitoring(for: circularRegion)
        }
    }
    
    
    
}
 

 
