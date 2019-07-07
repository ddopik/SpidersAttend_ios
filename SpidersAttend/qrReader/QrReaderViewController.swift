//
//  QrReaderViewController.swift
//  SpidersAttend
//
//  Created by ddopik on 7/4/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import UIKit
import AVFoundation
import QRCodeReader
class QrReaderViewController: BaseViewController,QRCodeReaderViewControllerDelegate {

    let currentViewController=self
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
    
    
     override func viewDidLoad() {
        super.viewDidLoad()
     }
    
  
    
    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scanAction()
    }
    
 
}
extension QrReaderViewController{
    
    
    
    func scanAction() {

        
        // Retrieve the QRCode content
        // By using the delegate pattern
        readerVC.delegate = self
        
        // Or by using the closure pattern
        //        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
        //            print("--->\(String(describing: result))")
        //        }
        
        // Presents the readerVC as modal form sheet
        //        readerVC.modalPresentationStyle = .formSheet
        
        present(readerVC, animated: true, completion: nil)
    }
    
    // MARK: - QRCodeReaderViewController Delegate Methods
    
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
        self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
        
//        navigateToMainStateScreen()
   
    }
    
 
    
}


