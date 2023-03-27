//
//  InfoView.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/6/23.
//

import UIKit


class InfoView: UIView {
 
    var markerDetail: Marker? {
        didSet{
            titleLbl.text = markerDetail?.name
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .none
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(icon)
//        addSubview(titleLbl)
        
        
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            icon.centerXAnchor.constraint(equalTo: centerXAnchor),
            icon.widthAnchor.constraint(equalToConstant: 28),
            icon.heightAnchor.constraint(equalToConstant: 28),
            
//            titleLbl.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -2),
//            titleLbl.leadingAnchor.constraint(equalTo: leadingAnchor),
//            titleLbl.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    lazy var icon : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "circle")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var titleLbl: UILabel = {
        let lbl = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: self.bounds.width, height: 40)))
        lbl.textColor = .black
        lbl.font = custom(name: .medium, size: 16, style: .caption1)
        lbl.numberOfLines = 2
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

}
