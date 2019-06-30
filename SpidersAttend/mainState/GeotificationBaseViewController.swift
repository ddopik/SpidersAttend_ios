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

class GeotificationBaseViewController : UIViewController{
    var geotifications:[Geotification] = [] 
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        loadAllGeotifications()
    }
    
    
    func startGeotiFication(){
        
//        let coordinate = mapView.centerCoordinate
//        let radius = Double(radiusTextField.text!) ?? 0
        let identifier = NSUUID().uuidString
        let note = "user get out"
        let eventType: Geotification.EventType = .onExit
        let coordinate = CLLocationCoordinate2D(latitude: 2.3, longitude: 4.4) 
          // 1
        let clampedRadius = min(20.0, locationManager.maximumRegionMonitoringDistance)
        let geotification = Geotification(coordinate: coordinate, radius: clampedRadius,
                                          identifier: identifier, note: note, eventType: eventType)
        add(geotification)
        
        startMonitoring(geotification: geotification)
        saveAllGeotifications()
    }
    
    
    // MARK: Loading and saving functions
    func loadAllGeotifications() {
        geotifications.removeAll()
        let allGeotifications = Geotification.allGeotifications()
        allGeotifications.forEach { add($0) }
    }
    
    
    func saveAllGeotifications() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(geotifications)
            UserDefaults.standard.set(data, forKey: PrefUtil.savedItems)
        } catch {
            print("error encoding geotifications")
        }
    }
    
    // MARK: Functions that update the model/associated views with geotification changes
    func add(_ geotification: Geotification) {
        geotifications.append(geotification)
    }
    
    func remove(_ geotification: Geotification) {
        guard let index = geotifications.index(of: geotification) else { return }
        geotifications.remove(at: index)
    }
    
    /***   With the location manager properly configured, you must now allow your app to register user geofences for monitoring.
     //    Your app stores the user geofence information within your custom Geotification model. However, to monitor geofences, Core Location requires you to represent each one as a CLCircularRegion instance. To handle this requirement, you’ll create a helper method that returns a CLCircularRegion from a given Geotification object.
     ***/
    func region(with geotification: Geotification) -> CLCircularRegion {
        // 1
        let region = CLCircularRegion(center: geotification.coordinate,
                                      radius: geotification.radius,
                                      identifier: geotification.identifier)
        // 2
        region.notifyOnEntry = (geotification.eventType == .onEntry)
        region.notifyOnExit = !region.notifyOnEntry
        return region
    }
    
    func startMonitoring(geotification: Geotification) {
        if !CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            showAlert(withTitle:"Error", message: "Geofencing is not supported on this device!")
            return
        }
        
        if CLLocationManager.authorizationStatus() != .authorizedAlways {
            let message = """
      Your geotification is saved but will only be activated once you grant
      Geotify permission to access the device location.
      """
            showAlert(withTitle:"Warning", message: message)
        }
        
        let fenceRegion = region(with: geotification)
        locationManager.startMonitoring(for: fenceRegion)
    }
    
    func stopMonitoring(geotification: Geotification) {
        for region in locationManager.monitoredRegions {
            guard let circularRegion = region as? CLCircularRegion, circularRegion.identifier == geotification.identifier else { continue }
            locationManager.stopMonitoring(for: circularRegion)
        }
    }
}

// MARK: - Location Manager Delegate
extension GeotificationBaseViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        mapView.showsUserLocation = status == .authorizedAlways
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Monitoring failed for region with identifier: \(region!.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager failed with the following error: \(error)")
    }
    
}
