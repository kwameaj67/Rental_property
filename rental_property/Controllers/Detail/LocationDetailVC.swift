//
//  LocationDetailVC.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/13/23.
//

import UIKit


class LocationDetailVC: UIViewController {
    
    let data: [LocationImage] = LocationImage.data
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        view.backgroundColor = .white
    }
    
    
    // MARK: Properties -
    lazy var container: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .red
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var imageView: UIView = {
        let v = UIView(frame: .zero)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var locationImage : LocationCollectionView = {
        var iv = LocationCollectionView()
        iv.images = data
        return iv
    }()
    
    lazy var backBtn: UIButton = {
        let btn = UIButton()
        let image = UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysTemplate).withConfiguration(UIImage.SymbolConfiguration(weight: .semibold))
        btn.setImage(image, for: .normal)
        btn.tintColor = .black
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 50/2
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.1
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 2)
        btn.layer.masksToBounds = false
        btn.addTarget(self, action: #selector(handleBackBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var starBtn: UIButton = {
        let btn = UIButton()
        let image = UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate).withConfiguration(UIImage.SymbolConfiguration(pointSize: 20,weight: .semibold))
        btn.setImage(image, for: .normal)
        btn.tintColor = .black
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 50/2
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.1
        btn.layer.shadowRadius = 8
        btn.layer.shadowOffset = CGSize(width: 0, height: 2)
        btn.layer.masksToBounds = false
        btn.addTarget(self, action: #selector(handleStarBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    lazy var locationDetailView: LocationDetailView = {
        let v = LocationDetailView(frame: .zero)
        v.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        v.layer.cornerRadius = 30
        return v
    }()

    // MARK: Selectors
    @objc func handleBackBtn(){
        generateHapticTouch()
        dismiss(animated: true)
    }
    
    @objc func handleStarBtn(){
        generateHapticTouch()
    }

    func setupViews(){
        view.addSubview(container)
        container.addSubview(imageView)
        imageView.addSubview(locationImage)
        container.addSubview(backBtn)
        container.addSubview(starBtn)
        container.addSubview(locationDetailView)
    }
    
    func setupConstraints(){
        container.pinToEdges(to: view)
        locationImage.pinToEdges(to: imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: container.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.6),
            
            backBtn.topAnchor.constraint(equalTo: container.topAnchor, constant: 50),
            backBtn.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            backBtn.heightAnchor.constraint(equalToConstant: 50),
            backBtn.widthAnchor.constraint(equalToConstant: 50),
            
            starBtn.centerYAnchor.constraint(equalTo: backBtn.centerYAnchor),
            starBtn.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            starBtn.heightAnchor.constraint(equalToConstant: 50),
            starBtn.widthAnchor.constraint(equalToConstant: 50),
            
            locationDetailView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            locationDetailView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            locationDetailView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            locationDetailView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.5),
        ])
    }
}
