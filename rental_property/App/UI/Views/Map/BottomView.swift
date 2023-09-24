//
//  BottomView.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/27/23.
//

import UIKit


protocol BottomViewDelegate: AnyObject {
    func didTapViewDetails(id: Int)
}

class BottomView: UIView{
    
    var location_id: Int = 0
    
    weak var controller: MapVC? {
        didSet{
            goBackbtn.addTarget(controller, action: #selector(controller?.handleBackBtn), for: .touchUpInside)
        }
    }
    
    weak var delegate: BottomViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Properties -
    lazy var titleLbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.textColor = .black
        lbl.font = custom(name: .semi_bold, size: 24, style: .caption1)
        lbl.numberOfLines = 2
        lbl.setLineHeight(lineHeight: 1.2)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.spacing = 20
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var goBackbtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Cancel", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: Font.medium.rawValue, size: 14)
        btn.backgroundColor = Color.black
        btn.layer.cornerRadius = 50/2
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    lazy var detailsBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("View Details", for: .normal)
        btn.setTitleColor(Color.black, for: .normal)
        btn.titleLabel?.font = UIFont(name: Font.medium.rawValue, size: 14)
        btn.backgroundColor = .white
        btn.layer.borderColor = Color.black.cgColor
        btn.layer.borderWidth = 2.0
        btn.layer.cornerRadius = 50/2
        btn.addTarget(self, action: #selector(handleDetailsBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    // MARK: Selectors -
    @objc func handleDetailsBtn(){
        delegate?.didTapViewDetails(id: location_id)
    }
    
    func setupViews(){
        addSubview(titleLbl)
        addSubview(stackView)
        stackView.addArrangedSubview(goBackbtn)
        stackView.addArrangedSubview(detailsBtn)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            titleLbl.topAnchor.constraint(equalTo: topAnchor, constant: 22),
            titleLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -34),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            goBackbtn.heightAnchor.constraint(equalToConstant: 50),
            detailsBtn.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
