//
//  ProfileView.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/6/23.
//

import UIKit


class ProfileView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var profileImage : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    
    func setupViews(){
        addSubview(profileImage)
    }
    func setupConstraints(){
        profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        profileImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        profileImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }
}
