//
//  GuestTableViewCell.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/10/23.
//

import UIKit

protocol GuestTableViewCellDelegate: AnyObject {
    func didTapMinusBtn()
    func didTapPlusBtn()
}

class GuestTableViewCell: UITableViewCell {

    static let reusableID = "GuestTableViewCell"
    
    weak var delegate: GuestTableViewCellDelegate?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: GuestTableViewCell.reusableID)
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
        lbl.text = "Number of guests"
        lbl.textColor = .black
        lbl.font = custom(name: .bold, size: 20, style: .caption1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.spacing = 10
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var minusBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "minus")?.withRenderingMode(.alwaysTemplate).withConfiguration(UIImage.SymbolConfiguration(pointSize: 22)), for: .normal)
        btn.tintColor = .black
        btn.backgroundColor = Color.grey
        btn.layer.cornerRadius = 20
        btn.addTarget(self, action: #selector(handleMinusBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    lazy var plusBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "plus")?.withRenderingMode(.alwaysTemplate).withConfiguration(UIImage.SymbolConfiguration(pointSize: 22)), for: .normal)
        btn.tintColor = .black
        btn.backgroundColor = Color.grey
        btn.layer.cornerRadius = 20
        btn.addTarget(self, action: #selector(handlePlusBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    lazy var numberView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = Color.grey
        v.layer.cornerRadius = 20
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    lazy var numberLbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "\(1)"
        lbl.textColor = .black
        lbl.font = custom(name: .medium, size: 18, style: .caption1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    // MARK: Selectors
    @objc func handlePlusBtn(){
        delegate?.didTapPlusBtn()
    }
    
    @objc func handleMinusBtn(){
        delegate?.didTapMinusBtn()
    }

    func setupViews(){
        contentView.addSubview(headingLbl)
        contentView.addSubview(stackView)
        numberView.addSubview(numberLbl)
        [minusBtn,numberView,plusBtn].forEach { item in
            stackView.addArrangedSubview(item)
        }
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            headingLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            headingLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            headingLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: headingLbl.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 60),
            
            minusBtn.heightAnchor.constraint(equalTo: stackView.heightAnchor),
            minusBtn.widthAnchor.constraint(equalTo: stackView.widthAnchor,multiplier: 0.2),
            plusBtn.heightAnchor.constraint(equalTo: stackView.heightAnchor),
            plusBtn.widthAnchor.constraint(equalTo: stackView.widthAnchor,multiplier: 0.2),
            
            numberView.heightAnchor.constraint(equalTo: stackView.heightAnchor),
            
            numberLbl.centerYAnchor.constraint(equalTo: numberView.centerYAnchor),
            numberLbl.centerXAnchor.constraint(equalTo: numberView.centerXAnchor),
        ])
    }
    
    

}
