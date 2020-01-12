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
    var newVacationDatePackerClos :((_ date:Date)->())!
    
    @IBOutlet weak var galenderPickerView: UIDatePicker!
    private var currentView :UIView!
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    
    
    class func getInstance(parentView : UIView,dele: @escaping (_ date: Date)  ->() )-> NewVacationDatePackerView{
        let mView = UINib(nibName: "NewVacationDatePackerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! NewVacationDatePackerView
        
        mView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        mView.center = CGPoint(x: parentView.bounds.midX, y: parentView.bounds.midY)
        mView.backgroundColor = UIColor.lightGray
        
        mView.layer.cornerRadius = 20.0
        mView.clipsToBounds = true
        mView.newVacationDatePackerClos = dele
        
        let today = Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 2, to: today as Date)
        mView.galenderPickerView.minimumDate =  tomorrow
        mView.currentView = mView
        return mView
    }
    
    @IBAction func OnCancelDateBtnClick(_ sender: Any) {
        newVacationDatePackerViewDelegate?.onDateDismessed()
        self.isHidden = true
    }
    
    @IBAction func OnConfirmDateBtnClick(_ sender: Any) {
        
        newVacationDatePackerClos(datePickerView.date)
        self.isHidden = true
    }
    
    
    public func showDatePickerDialog(parentView: UIView){
        self.isHidden = false
        
        parentView.addSubview(currentView)
    }
}



protocol NewVacationDatePackerViewDelegate {
    func onDateDismessed ()
}
