//
//  FilterFooterView.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/11/23.
//

import UIKit

protocol FilterFooterViewDelegate: AnyObject {
    func didTapApplyBtn()
}

class FilterFooterView: UITableViewHeaderFooterView {

  static let reusableID = "FilterFooterView"
    
    weak var delegate: FilterFooterViewDelegate?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: FilterFooterView.reusableID)
        let bg_view = UIView()
        bg_view.backgroundColor = .white
        backgroundView = bg_view
        addSubview(applyBtn)
        
        // constraints
        applyBtn.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        applyBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        applyBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        applyBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    let applyBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Apply", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = custom(name: .semi_bold, size: 18, style: .caption1)
        btn.backgroundColor = Color.black
        btn.addTarget(self, action: #selector(handleApplyBtn), for: .touchUpInside)
        btn.layer.cornerRadius = 20
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    @objc func handleApplyBtn(){
        
    }
}
