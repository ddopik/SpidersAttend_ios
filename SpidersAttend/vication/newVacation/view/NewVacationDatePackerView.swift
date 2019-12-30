//
//  NewVacationDatePackerView.swift
//  SpidersAttend
//
//  Created by ddopik on 12/29/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
import UIKit
class NewVacationDatePackerView : UIView{
    
    var newVacationDatePackerViewDelegate :NewVacationDatePackerViewDelegate!
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    
    private var parentView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init (parentView : UIView){
          self.parentView = parentView
        super.init(frame: UIScreen.main.bounds)
    }
    
    @IBAction func OnCancelDateBtnClick(_ sender: Any) {
        newVacationDatePackerViewDelegate?.onDateDismessed()
        self.isHidden = true
    }
    
    @IBAction func OnConfirmDateBtnClick(_ sender: Any) {
        let dateFormat = DateFormatter()
        dateFormat.timeStyle = DateFormatter.Style.short
        let date = dateFormat.string(from: datePickerView.date)
        _ = newVacationDatePackerViewDelegate?.onDateSelected(date:date)
        self.isHidden = true
        
    }
    public func showDatePickerDialog() {
//        let mframe =  CGRect(x: 0, y: 0, width: parentView.frame.width, height: parentView.frame.height )
//        self.frame = mframe
        let mView = UINib(nibName: "NewVacationDatePackerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        mView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        mView.center = CGPoint(x: self.parentView.bounds.midX, y: self.parentView.bounds.midY)
        mView.backgroundColor = UIColor.lightGray
 
        mView.layer.cornerRadius = 20.0
        mView.clipsToBounds = true
        
         parentView.addSubview(mView)
     }
    
}



protocol NewVacationDatePackerViewDelegate {
    func onDateSelected(date :String)
    func onDateDismessed ()
}
