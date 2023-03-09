//
//  FilterVC+Delegates.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/9/23.
//

import UIKit



extension FilterVC: FilterHeaderViewDelegate {
    func dismissVC() {
        print("DEBUG: dismiss FilterVC")
        dismiss(animated: true)
    }
    
    func resetFilters() {
        print("DEBUG: reset filters")
    }
    
    
}
