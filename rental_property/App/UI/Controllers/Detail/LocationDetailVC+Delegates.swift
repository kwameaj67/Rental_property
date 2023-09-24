//
//  LocationDetailVC+Delegates.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/13/23.
//

import UIKit

// MARK: - panGestureRecognizerHandler
extension LocationDetailVC {
    @objc func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
       dragView(sender)
    }
}
