//
//  UIView.swift
//  SpidersAttend
//
//  Created by ddopik on 12/17/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    /*
     set rounded corners for current view
     */
    func rountCorners(){
        let cardRadious = bounds.maxX/6
        layer.cornerRadius = cardRadious
    }
}
