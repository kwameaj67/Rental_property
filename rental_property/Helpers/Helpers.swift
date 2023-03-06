//
//  Helpers.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/6/23.
//

import UIKit


// MARK: - delay
func delay(duration: Double, completion: @escaping () -> Void){
    DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: completion)
}
