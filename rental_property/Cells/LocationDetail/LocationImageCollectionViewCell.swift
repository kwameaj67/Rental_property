//
//  LocationImageCollectionViewCell.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/18/23.
//

import UIKit

class LocationImageCollectionViewCell: UICollectionViewCell {
    
    static let reusableID = "LocationImageCollectionViewCell"
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(locationImage)
        
        locationImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        locationImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        locationImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        locationImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var locationImage : UIImageView = {
        var iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .systemGray5
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

}
