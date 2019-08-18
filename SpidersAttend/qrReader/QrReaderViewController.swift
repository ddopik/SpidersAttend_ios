//
//  QrReaderViewController.swift
//  SpidersAttend
//
//  Created by ddopik on 7/7/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import UIKit
import AVFoundation
import QRCodeReader
import CoreLocation

class QrReaderViewController: BaseViewController,QRCodeReaderViewControllerDelegate {
    var newStart :Bool = true
    var cuurentQrLocation :CLLocation?
    ///
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            
            // Configure the view controller (optional)
            $0.showTorchButton        = true
            $0.showSwitchCameraButton = false
            $0.showCancelButton       = true
            $0.showOverlayView        = true
            $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    ///
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newStart=true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if newStart {
        readerVC.delegate = self
    
        // Presents the readerVC as modal form sheet
        readerVC.modalPresentationStyle = .formSheet
        present(readerVC, animated: true, completion: nil)
            self.newStart=false
        }else {
            dismiss(animated: true, completion: nil)

        }
    }
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {

        reader.stopScanning()
         print("**********---> "+result.value)
        if(result.value == ApiConstant.QR_SCANNER_CONSTANT){
            sendAttendRequest()
        }else{
            self.dismiss(animated: true, completion: nil)
            showAlert(withTitle: "", message: "Wrong QrCode".localiz())
        }
        
    
    }

    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()

        dismiss(animated: true, completion: nil)
 
    }
  
    
    func sendAttendRequest(){
        
        startProgress()
        let succ={ (checkStatusResponse:CheckStatusResponse?)   in
            print("sendAttendRequest ---->\(String(checkStatusResponse?.data.attendStatus?.msg ?? "null message"))")

            
            if let statsId =  checkStatusResponse?.data.attendStatus.status {
                PrefUtil.setCurrentUserStatsID(userStats: statsId)
                self.stopProgress()
                                self.dismiss(animated: true, completion: nil)

                self.viewAttendMessage(currenrStatsID: statsId)
                
            }

            
        }
        let failureClos={
            (err : Any) in
            if (err is NetworkBaseError){
                //                (err:NetworkBaseError?)   in
                print("failed ---->\(String(describing: (err as! NetworkBaseError).data?.msg))")
                _ = self.showSimpleConfirmDialog(parent: self, messageText: ((err as! NetworkBaseError).data?.msg) ?? "failed",messageTitle: "Error", buttonText: "Ok")
                ///disaple progressView here
                
                
            }else{
                _ = self.showSimpleConfirmDialog(parent: self, messageText: "Network Error",messageTitle: "Error", buttonText: "Ok")
            }
             self.stopProgress()
            self.dismiss(animated: true, completion: nil)


        }
      
        let requestPatameter = [
            "uid":PrefUtil.getUserId(),
            "platform":"ios",
            "device":UIDevice.modelName,
            "device_details": UIDevice.modelName,
            "imei":(UIDevice.current.identifierForVendor?.uuidString as! String),
            "latitude":"\(cuurentQrLocation?.coordinate.latitude ?? 0.0)" as String,
            "longitude": "\(cuurentQrLocation?.coordinate.longitude ?? 0.0)" as String,
            "mobile_flag":"1",
            ] as! [String : String]
      
        
        do {
            try APIRouter.makePostRequesr(url: APIRouter.ATTEND_ACTION, bodyParameters: requestPatameter, succese: succ, failure: failureClos as! (Any?) -> (), type: CheckStatusResponse.self)
        }catch{
            let errorObj = error as! ValidationError
            showAlert(withTitle: errorObj.errorTitle, message: errorObj.message)
        }
        
    }
    
    
    private func viewAttendMessage(currenrStatsID:String){
         let onComplete = {
            self.dismiss(animated: true, completion: nil)
        }
        if(currenrStatsID == ApiConstant.OUT){
              _ =  self.showSimpleConfirmDialog(parent: self, messageText: "",messageTitle: "Welcome".localiz()+" "+PrefUtil.getUserName()!, buttonText: "Ok".localiz(),onCompl: onComplete)
        }else if(currenrStatsID == ApiConstant.ENDED){
               _ =    self.showSimpleConfirmDialog(parent: self, messageText: "",messageTitle: "By By".localiz()+" "+PrefUtil.getUserName()!, buttonText: "Ok".localiz(),onCompl: onComplete)
        }
    }
    
}
public extension UIDevice {
    
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad6,11", "iPad6,12":                    return "iPad 5"
            case "iPad7,5", "iPad7,6":                      return "iPad 6"
            case "iPad11,4", "iPad11,5":                    return "iPad Air (3rd generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad11,1", "iPad11,2":                    return "iPad Mini 5"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
    
}
