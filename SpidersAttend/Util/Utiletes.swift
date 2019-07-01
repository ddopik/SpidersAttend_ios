//
//  Utiletes.swift
//  SpidersAttend
//
//  Created by ddopik on 6/30/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
import UIKit
import MapKit

// MARK: Helper Extensions
extension UIViewController {
    func showAlert(withTitle title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension MKMapView {
    func zoomToUserLocation() {
        guard let coordinate = userLocation.location?.coordinate else { return }
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        setRegion(region, animated: true)
    }
}

extension BaseViewController{
  func generate(parent: UIViewController, messageText: String, messageTitle: String, buttonText: String) -> UIAlertController {
    let alert = UIAlertController(title: messageTitle, message: messageText, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: buttonText, style: UIAlertAction.Style.default, handler: nil))
    parent.present(alert, animated: true, completion: nil)
    return alert
}
}
