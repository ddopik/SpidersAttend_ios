//
//  UIUtiletes.swift
//  SpidersAttend
//
//  Created by ddopik on 7/10/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

extension BaseViewController {
    
    public  func startProgress() {
        self.progressView.isHidden = false
        self.view.layoutIfNeeded()
    }
    
    func stopProgress(){
        //        progressView.removeFromSuperview()
        self.progressView.isHidden = true
        self.view.layoutIfNeeded()
        
    }
    func setupUnroundedIndeterminate() {
        view.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(view).multipliedBy(0.4)
        }
    }
    
    
    
    
      func constrain(_ newView: UIView, leftView: UIView) {
        progressView.addSubview(newView)
        newView.snp.makeConstraints { (make) in
            make.size.equalTo(60)
            make.center.equalToSuperview()
            make.top.equalTo(265)
            
            
            
            self.progressView.isHidden = true
            self.view.layoutIfNeeded()
        }
    }
     var unroundedIndeterminate: RPCircularProgress  {
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
     var thinFilledIndeterminate: RPCircularProgress   {
        get {
            let progress = RPCircularProgress()
            progress.innerTintColor = UIColor.red
            progress.thicknessRatio = 0.2
            progress.indeterminateDuration = 0.5
            return progress
        }}
    
}
