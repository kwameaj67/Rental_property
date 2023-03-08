//
//  PropertyDetail.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/8/23.
//

import Foundation


struct PropertyDetail: Decodable {
    var location_id: Int
    var location: String
    var sleeps: Int
    var description: String
    var features: [String]
    var guests: Int
    var price: Double
    var image_url: String
}
