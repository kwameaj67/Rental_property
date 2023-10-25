//
//  FeatureCollectionViewCell.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/11/23.
//

import UIKit

class FeatureCollectionViewCell: UICollectionViewCell {
    
    var data: Feature? {
        didSet{
            guard let item = data else { return }
            lbl.text = item.name
        }
    }
    static let reusableID = "FeatureCollectionViewCell"
    
    override var isSelected: Bool{
        didSet{
            UIView.animate(withDuration: 0.2) {
                self.layer.borderWidth = self.isSelected ? 3 : 0
                self.layer.borderColor = self.isSelected ? UIColor.black.cgColor : .none
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
        backgroundColor = .white
        layer.cornerRadius =  20
        
        // shadows
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 6
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.masksToBounds = false
//        layer.shouldRasterize =  true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
    lazy var lbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textColor = .black
        lbl.font = custom(name: .regular, size: 16, style: .caption1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    // MARK: Properties -
    func setupViews(){
        addSubview(lbl)
    }
    func setupContraints(){
        lbl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        lbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        lbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
    }
}
