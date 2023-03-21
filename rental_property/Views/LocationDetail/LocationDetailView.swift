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
        lbl.text = "Woltsend Cottages"
        lbl.textColor = .black
        lbl.font = custom(name: .semi_bold, size: 26, style: .headline)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    lazy var locationImg : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "location")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .systemGray3
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    lazy var locationLbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "Wakefield, England"
        lbl.textColor = .black
        lbl.font = custom(name: .regular, size: 16, style: .headline)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    lazy var guestImg : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "sleep")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = .systemGray3
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    lazy var guestLbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "6 sleeps"
        lbl.textColor = .black
        lbl.font = custom(name: .regular, size: 16, style: .headline)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    lazy var descriptionLbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "Situated in the picturesque area called Breckland in South Norfolk. Woldsend is location in one of the driest terrains in the UK."
        lbl.textColor = .black
        //lbl.backgroundColor = .red
        lbl.numberOfLines = 3
        lbl.setLineHeight(lineHeight: 1.8)
        lbl.font = custom(name: .regular, size: 16, style: .headline)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    lazy var priceLbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    lazy var bookBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Book", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: Font.medium.rawValue, size: 14)
        btn.backgroundColor = Color.black
        btn.layer.cornerRadius = 20
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    lazy var collectionView: ConvenienceCollectionView = {
        let v = ConvenienceCollectionView(frame: .zero)
        return v
    }()

    func setupViews(){
        [headingLbl,locationImg,locationLbl,guestImg,guestLbl,descriptionLbl,priceLbl,bookBtn,collectionView].forEach { item in
            addSubview(item)
        }
        priceLbl.attributedText = setAttibutedText(150, "night")
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            headingLbl.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            headingLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            headingLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            
            locationImg.topAnchor.constraint(equalTo: headingLbl.bottomAnchor, constant: 20),
            locationImg.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            locationImg.heightAnchor.constraint(equalToConstant: 20),
            locationImg.widthAnchor.constraint(equalToConstant: 20),
            
            locationLbl.centerYAnchor.constraint(equalTo: locationImg.centerYAnchor),
            locationLbl.leadingAnchor.constraint(equalTo: locationImg.trailingAnchor, constant: 10),
            
            guestImg.topAnchor.constraint(equalTo: headingLbl.bottomAnchor, constant: 20),
            guestImg.trailingAnchor.constraint(equalTo: guestLbl.leadingAnchor, constant: -10),
            guestImg.heightAnchor.constraint(equalToConstant: 20),
            guestImg.widthAnchor.constraint(equalToConstant: 20),
            
            guestLbl.centerYAnchor.constraint(equalTo: guestImg.centerYAnchor),
            guestLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            
            descriptionLbl.topAnchor.constraint(equalTo: locationImg.bottomAnchor, constant: 25),
            descriptionLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            descriptionLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            
            collectionView.topAnchor.constraint(equalTo: descriptionLbl.bottomAnchor,constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
            
            priceLbl.centerYAnchor.constraint(equalTo: bookBtn.centerYAnchor),
            priceLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            
            bookBtn.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40),
            bookBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            bookBtn.heightAnchor.constraint(equalToConstant: 50),
            bookBtn.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func setAttibutedText(_ price: Double,_ period: String ) -> NSMutableAttributedString {
        let text = NSMutableAttributedString(string: "￡\(price)",attributes: [.foregroundColor: UIColor.black,.font: custom(name: .bold, size: 22, style: .caption1)])
        text.append(NSAttributedString(string: "\n  /\(period)",attributes: [.foregroundColor: UIColor.black,.font: custom(name: .regular, size: 16, style: .caption1)]))
        return text
    }
}
