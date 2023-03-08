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

func sizeImage(_ originalImage:UIImage, scaledToSize:CGSize) -> UIImage {
    if originalImage.size.equalTo(scaledToSize) {
        return originalImage
    }
    UIGraphicsBeginImageContextWithOptions(scaledToSize, false, 0.0)
    originalImage.draw(in: CGRect(x: 0, y: 0, width: scaledToSize.width, height: scaledToSize.height))
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
}
