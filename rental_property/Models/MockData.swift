//
//  MockData.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/6/23.
//

import Foundation



struct Marker {
    dynamic var name: String
    var lat: Double
    var lng: Double
    
    
    static let data: [Marker] = [
        Marker(name: "Ajax Park 3", lat: 5.6429215, lng: -0.1800884),
        Marker(name: "Tickles Food Court", lat:5.6355777, lng: -0.182141),
        Marker(name: "Nestle Ghana", lat: 5.6341515, lng: -0.180733),
        Marker(name: "Noguchi Memorial Institute for Medical Research", lat: 5.6304567, lng: -0.1777776),
        Marker(name: "Ghana Standards Authority", lat: 5.6298216, lng: -0.1743329),
    ]
}
