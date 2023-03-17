//
//  LocationDetail.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/14/23.
//

import UIKit



class LocationDetailView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Properties -
    lazy var headingLbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "Voltand Cottages"
        lbl.textColor = .black
        lbl.font = custom(name: .semi_bold, size: 20, style: .headline)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    

    func setupViews(){
        
    }
    
    func setupContraints(){
        
    }
}
