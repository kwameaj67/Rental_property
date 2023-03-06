//
//  SearchView.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/6/23.
//

import UIKit

class SearchView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 20
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    lazy var searchBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var searchTextField : UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "Search property or location"
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.font = custom(name: .medium, size: 18, style: .caption1)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    lazy var filterBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "setting")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()


    func setupViews(){
        [searchBtn,searchTextField,filterBtn].forEach { item in
            addSubview(item)
        }
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            searchBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            searchBtn.widthAnchor.constraint(equalToConstant: 22),
            searchBtn.heightAnchor.constraint(equalToConstant: 22),
            
            searchTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: searchBtn.trailingAnchor, constant: 8),
            searchTextField.trailingAnchor.constraint(equalTo: filterBtn.leadingAnchor, constant: -8),
            searchTextField.heightAnchor.constraint(equalToConstant: 35),
            
            filterBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            filterBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            filterBtn.widthAnchor.constraint(equalToConstant: 22),
            filterBtn.heightAnchor.constraint(equalToConstant: 22),
        ])
    }
}
