//
//  MainStateViewController.swift
//  SpidersAttend
//
//  Created by ddopik on 6/26/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import UIKit
import CoreLocation
class MainStateViewController: GeotificationBaseViewController {
    /// PaintCode used for drawing a custom clock
    
    @IBOutlet weak var clockView: ClockView!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet var tapGetureRecognizer: UITapGestureRecognizer!
    
    private var timer: Timer!
    private var observer: NSObjectProtocol?

    // the Model
    public var timeToDisplay: Date? {
        willSet {
            guard let newDate = newValue else { return }
            updateView(newDate: newDate)
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
           super.onLocationUpdateDelegate = self
        
        
     
        
        
        
        
        
        
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateAction), userInfo: nil, repeats: true)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        // if timeToDisplay is nil, set it and return
        // otherwise it was set by a different controller
        guard let _ = timeToDisplay else {
            timeToDisplay = updateNow()
            return
        }
        
     
    }
    
    @IBAction func attendButton(_ sender: Any) {
//      super.requestFencing()
        do{
            try startLocationServices()
        }
        catch{
            print("MainStateViewController ----> \(Error.self)")
        }
     }
    
   @objc  func appMovedToForeground() {
        print("App moved to ForeGround!")
    /// recall check Api here
    }
    
    
   
    @objc func willEnterForeground() {
        print("App moved to Background!")
    }
 

    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    func updateView(newDate: Date) {
        title = "Attend"
        clockView?.timeToDisplay = newDate
        dateTimeLabel?.text = newDate.asDateTimeString()
    }
    
    @objc
    @IBAction func updateAction(_ sender: Any) {
        timeToDisplay = updateNow()
    }
    
    func updateNow() -> Date {
        return Date()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        clockView = nil
        timer.invalidate()
        timer = nil
    }
    
    
 
}

extension MainStateViewController : OnLocationUpdateDelegate{
    func onLocationUpdated(curenrtlocation: CLLocation) {
        startGeotiFication(  curenrtlocation.coordinate.latitude,curenrtlocation.coordinate.longitude);
    }
}

