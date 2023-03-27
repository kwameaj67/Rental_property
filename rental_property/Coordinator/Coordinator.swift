//
//  Coordinator.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/26/23.
//

import Foundation
import UIKit


class MainCoordinator {
    var locations = [PropertyLocation]()
    
    var navigationController = UINavigationController()
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
}
