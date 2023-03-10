//
//  PriceTableViewCell.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/10/23.
//

import UIKit

protocol PriceTableViewCellDelegate : AnyObject {
    func didTapPropertyView()
}
class PriceTableViewCell: UITableViewCell {

    static let reusableID = "PriceTableViewCell"
    
    weak var delegate: PriceTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: PriceTableViewCell.reusableID)
        setupViews()
        setupContraints()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    lazy var headingLbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "Price"
        lbl.textColor = .black
        lbl.font = custom(name: .bold, size: 20, style: .caption1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    lazy var textFieldStackView: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.spacing = 10
        sv.axis = .horizontal
        sv.backgroundColor = .none
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var fromTextField : CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "From"
        return tf
    }()
    
    lazy var toTextField : CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "To"
        return tf
    }()
    
    lazy var propertyView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = Color.grey
        v.layer.cornerRadius = 15
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var propertyLbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "Property Type"
        lbl.textColor = .systemGray3
        lbl.font = custom(name: .regular, size: 16, style: .caption1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var propertyIcon : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate).withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
        iv.tintColor = .black
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()



    func setupViews(){
        contentView.addSubview(headingLbl)
        contentView.addSubview(textFieldStackView)
        textFieldStackView.addArrangedSubview(fromTextField)
        textFieldStackView.addArrangedSubview(toTextField)
        contentView.addSubview(propertyView)
        propertyView.addSubview(propertyLbl)
        propertyView.addSubview(propertyIcon)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            headingLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            headingLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            headingLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            textFieldStackView.topAnchor.constraint(equalTo: headingLbl.bottomAnchor, constant: 15),
            textFieldStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textFieldStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            textFieldStackView.heightAnchor.constraint(equalToConstant: 60),
            
            fromTextField.heightAnchor.constraint(equalTo: textFieldStackView.heightAnchor),
            toTextField.heightAnchor.constraint(equalTo: textFieldStackView.heightAnchor),
            
            propertyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            propertyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            propertyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            propertyView.heightAnchor.constraint(equalToConstant: 60),
            
            propertyLbl.centerYAnchor.constraint(equalTo: propertyView.centerYAnchor),
            propertyLbl.leadingAnchor.constraint(equalTo: propertyView.leadingAnchor, constant: 20),
            
            propertyIcon.centerYAnchor.constraint(equalTo: propertyView.centerYAnchor),
            propertyIcon.widthAnchor.constraint(equalToConstant: 16),
            propertyIcon.heightAnchor.constraint(equalToConstant: 16),
            propertyIcon.trailingAnchor.constraint(equalTo: propertyView.trailingAnchor, constant: -20),
        ])
    }
}
