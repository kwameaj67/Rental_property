//
//  Location.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/8/23.
//

import Foundation


struct PropertyLocation: Decodable {
    var name: String
    var coordinate: Coordinate
    
    struct Coordinate: Decodable {
        var latitude: Double
        var longitude: Double
    }
}
