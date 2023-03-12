//
//  FilterHeaderView.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/9/23.
//

import UIKit

protocol FilterHeaderViewDelegate: AnyObject {
    func dismissVC()
    func resetFilters()
}
class FilterHeaderView: UIView {
    
    weak var delegate: FilterHeaderViewDelegate?
    
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
    
    // MARK: Properties
    lazy var exitBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate).withConfiguration(UIImage.SymbolConfiguration(pointSize: 20,weight: .semibold)), for: .normal)
        btn.tintColor = .black
        btn.backgroundColor = .none
        btn.addTarget(self, action: #selector(handleExitBtn), for: .primaryActionTriggered)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var headingLbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "Filters"
        lbl.textColor = .black
        lbl.font = custom(name: .bold, size: 22, style: .headline)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var resetBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Reset", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = custom(name: .medium, size: 20, style: .caption1)
        btn.addTarget(self, action: #selector(handleResetBtn), for: .primaryActionTriggered)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    // MARK: Selectors -
    @objc func handleExitBtn(){
        generateHapticTouch()
        delegate?.dismissVC()
    }
    
    @objc func handleResetBtn(){
        delegate?.resetFilters()
    }
    
    func setupViews(){
        addSubview(exitBtn)
        addSubview(headingLbl)
        addSubview(resetBtn)
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            exitBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            exitBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            exitBtn.widthAnchor.constraint(equalToConstant: 25),
            exitBtn.heightAnchor.constraint(equalToConstant: 25),
            
            headingLbl.centerYAnchor.constraint(equalTo: exitBtn.centerYAnchor),
            headingLbl.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            resetBtn.centerYAnchor.constraint(equalTo: exitBtn.centerYAnchor),
            resetBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            resetBtn.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
}
