//
//  UIFont+Ext.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/5/23.
//

import UIKit

enum Font: String {
    case bold  = "Outfit-Bold"
    case medium = "Outfit-Medium"
    case light  = "Outfit-Light"
    case regular = "Outfit-Regular"
    case semi_bold  = "Outfit-SemiBold"
    
}

func custom(name: Font, size: CGFloat, style: UIFont.TextStyle) -> UIFont{
    let font  = UIFont(name: name.rawValue, size: size)!
    return UIFontMetrics(forTextStyle: style).scaledFont(for: font)
}
    

