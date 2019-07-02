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
    @IBOutlet weak var stateMessage: UITextView!
    @IBOutlet var tapGetureRecognizer: UITapGestureRecognizer!
    private var timer: Timer!
    private var timeToDisplay: Date? {
        willSet {
            guard let newDate = newValue else { return }
            updateView(newDate: newDate)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.onLocationUpdateDelegate = self
        setCloclView()
        requestUserStatus()
        
    }
    
    @IBAction func attendButton(_ sender: Any) {
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
    
}
/////////////////////////////////////////////////

extension MainStateViewController{
    
    
    private func setCloclView(){
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
    func updateView(newDate: Date) {
        title = "Attend"
        clockView?.timeToDisplay = newDate
        dateTimeLabel?.text = newDate.asDateTimeString()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
}

////////////////////////////////////


extension MainStateViewController : OnLocationUpdateDelegate{
    func onLocationUpdated(curenrtlocation: CLLocation) {
        startGeotiFication(  curenrtlocation.coordinate.latitude,curenrtlocation.coordinate.longitude);
    }
}


extension MainStateViewController{
    
    
    
    func requestUserStatus(){
        
        let succ={ (checkStatusResponse:CheckStatusResponse?) in
            
            print("horaaaaaai------> \(String(describing: checkStatusResponse?.data.attendStatus.msg))"
            )
            
            if let statsId = try? checkStatusResponse?.data.attendStatus.status {
                PrefUtil.setCurrentUserStatsID(userStats: statsId)
                self.stateMessage.text=checkStatusResponse?.data.attendStatus.msg
                
            }
            
        }
        let failureClos={
            (err:NetworkBaseError?) in
            print("failed ---->\(String(describing: err?.data?.msg))")
            _ = self.generate(parent: self, messageText: (err?.data?.msg) ?? "failed",messageTitle: "Error", buttonText: "Ok")
        }
        
        _=APIRouter.globalRequest(url: APIRouter.CHECK_STATUS_URL, bodyParameters: ["uid" : PrefUtil.getUserId() ?? "3" ], succese: succ, failure: failureClos, type: CheckStatusResponse.self)
    }
    
    
}

