//
//  MockData.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/6/23.
//

import Foundation



struct Marker {
    var name: String
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


class FilterCondition {
    var priceFrom: Double = 0.0
    var priceTo: Double = 0.0
    var propertyType: String = ""
    var conveniences: [String] = []
    var numberOfGuest: Int = 1
}

struct LocationImage {
    var image: String
    
    static let data: [LocationImage] = [
        LocationImage(image: "house"),
        LocationImage(image: "house2"),
        LocationImage(image: "house3")
    ]
}

struct Feature{
    var name: String
    
    static let data: [Feature] = [
        Feature(name: "Extra Space"),
        Feature(name: "TV"),
        Feature(name: "In the woods"),
        Feature(name: "Storage Area"),
        Feature(name: "Large Windows"),
        Feature(name: "Views"),
        Feature(name: "Hot Tubs"),
        Feature(name: "Huge Bathroom"),
        Feature(name: "Open Floor"),
        Feature(name: "Woodburner"),
        Feature(name: "Ensuite Bedrooms"),
        Feature(name: "Fruit Trees"),
        Feature(name: "Garage"),
        Feature(name: "Swimming Pool"),
        Feature(name: "Dining Room"),
        Feature(name: "Natural Light"),
        Feature(name: "Balconies"),
        Feature(name: "Private Roof Tops"),
        Feature(name: "Master Suites"),
        Feature(name: "Ample Parking"),
        Feature(name: "Family Friendly"),
        
       
       
    ]
}
