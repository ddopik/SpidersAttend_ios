//
//  AttendViewController.swift
//  SpidersAttend
//
//  Created by Abd Alla maged on 1/23/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
//
// AttendViewController.swift
// SpidersAttend
//
// Created by ddopik on 8/7/19.
// Copyright © 2019 Brandeda. All rights reserved.
//
import UIKit
import CoreLocation
class AttendViewController: BaseViewController {
   
   
   
  @IBOutlet weak var statsMessage: UITextView!
  @IBOutlet weak var qrAttendButton: UIButton!
  @IBOutlet weak var attendActionContainer: UIStackView!
   
  private  var currentAttendMethod :AttendMethod!
  private var attendPresenter: AttendPresenter!
   
  override func viewDidLoad() {
    super.viewDidLoad()
    super.onLocationUpdateDelegate = self
    attendPresenter = AttendPresenterImpl(attendView: self)
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    attendPresenter.requestUserStatus()
     
  }
   
   
  @IBAction func qrAttendButton(_ sender: Any) {
    // Call back found through locationDelegate
    do{
      currentAttendMethod = AttendMethod.QR
      try super.startLocationServices()
    }
    catch{
      showAlert(withTitle: "Error", message: error.localizedDescription)
      stopLocationManger()
    }
     
  }
   
   
  @IBAction func networkAttendButton(_ sender: Any) {
    // Call back found through locationDelegate
    do{
      currentAttendMethod = AttendMethod.NETWORK
      try super.startLocationServices()
    }
    catch{
      showAlert(withTitle: "Error", message: error.localizedDescription)
      stopLocationManger()
    }
     
  }
   
   
}
extension AttendViewController:AttendView{
   
  func requestAttendAction(){
     
    startProgress()
    do{
      //step ->1
      /*
       start location Updater and region Fencing
       */
      try self.startLocationServices()
    }
    catch{
      print("AttendViewController ----> \(Error.self)")
      self.stopProgress()
    }
  }
   
}
extension AttendViewController{
   
  func viewProgress(state: Bool) {
    if state {
      super.startProgress()
    }else{
      super.stopProgress()
    }
  }
  func setAttendBtnState(state: Bool) {
    if !state{
      //      qrAttendButton.backgroundColor = .gray
      self.qrAttendButton.isEnabled=false
    }else{
      //      qrAttendButton.backgroundColor = .blue
      self.qrAttendButton.isEnabled=true
    }
     
  }
  func viewDialogMessage(title: String, message: String) {
    self.showSimpleConfirmDialog(parent: self, messageText:message,messageTitle: title, buttonText: "Ok")
  }
   
  func viewAlertMessage(title: String, message: String) {
    super.showAlert(withTitle:title,message:message)
  }
  func setAttendMessageStates(statsID: String) {
    if(statsID == ApiConstant.ENTER){
      self.statsMessage.text = "Please select method to Attend".localiz()
      self.attendActionContainer.isHidden = false
       
    }else if(statsID == ApiConstant.OUT){
      self.statsMessage.text = "Please select method to Leave".localiz()
      self.attendActionContainer.isHidden = false
       
    }
    else if(statsID == ApiConstant.ENDED){
        self.statsMessage.text = "your Attend has been taken fot today".localiz()
      self.attendActionContainer.isHidden = true
    }
     
    statsMessage.centerVertically()
  }
   
  func viewAttendMessage(currenrStatsID: String) {
    // dialog after Attend suc
  }
   
   
  func navigate(dest: NavigationType,curenrtlocation: CLLocation) {
    if(dest == NavigationType.QRReader){
      ////( Attend / Leave ) user through Qr Scanner
      let navigationManger = NavigationManger(storyboard: self.storyboard!,viewController: self)
      navigationManger.setQrViewControllerMessage(cuurentLocation: curenrtlocation)
      navigationManger.navigateTo(target :Destinations.QrScanner)
    }
  }
   
}
extension AttendViewController : OnLocationUpdateDelegate {
   
   
   
   
  func onLocationUpdated(curenrtlocation: CLLocation) {
    self.setAttendBtnState(state: true)
    self.stopProgress()
    let newLocation = curenrtlocation
    //The last location must not be capured more then 3 seconds ago
    print( " horizontalAccuracy \(curenrtlocation.horizontalAccuracy )" )
    let centralLat = PrefUtil.getCurrentCentralLat()
    let centralLng = PrefUtil.getCurrentCentralLng()
    let centrallocation = CLLocation(latitude: centralLat, longitude: centralLng)
    let anotherLocation = CLLocation(latitude: newLocation.coordinate.latitude,longitude: newLocation.coordinate.longitude)
    let distance = centrallocation.distance(from: anotherLocation)
     
    print("destance is ----> \(distance) ")
     
     
     
     
    if( PrefUtil.getCurrentCentralRadius()! >= distance ){
      self.attendPresenter.sendAttendAction(attendType: self.currentAttendMethod, curenrtlocation: curenrtlocation)
    } else{
      showAlert(withTitle: "Error", message: "you are out of area")
       
    }
  }
   
  func onLocationUpdateFailed(error: Error) {
    self.stopLocationManger()
    showAlert(withTitle: "Error".localiz(), message: "locationError".localiz())
  }
   
   
   
   
   
}












 
