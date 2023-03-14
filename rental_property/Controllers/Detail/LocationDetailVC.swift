//
//  LocationDetailVC.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/13/23.
//

import UIKit

class LocationDetailVC: UIViewController {
    
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
    
    lazy var locationImage : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "house")?.withRenderingMode(.alwaysOriginal)
        iv.isUserInteractionEnabled = true
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var backBtn: UIButton = {
        let btn = UIButton()
        let image = UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysTemplate).withConfiguration(UIImage.SymbolConfiguration(weight: .semibold))
        btn.setImage(image, for: .normal)
        btn.tintColor = .black
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 45/2
        btn.addTarget(self, action: #selector(handleBackBtn), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var starBtn: UIButton = {
        let btn = UIButton()
        let image = UIImage(named: "star")?.withRenderingMode(.alwaysTemplate).withConfiguration(UIImage.SymbolConfiguration(pointSize: 10))
        btn.setImage(image, for: .normal)
        btn.tintColor = .black
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 45/2
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
        locationImage.addSubview(backBtn)
        locationImage.addSubview(starBtn)
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
            
            backBtn.topAnchor.constraint(equalTo: locationImage.topAnchor, constant: 40),
            backBtn.leadingAnchor.constraint(equalTo: locationImage.leadingAnchor, constant: 20),
            backBtn.heightAnchor.constraint(equalToConstant: 45),
            backBtn.widthAnchor.constraint(equalToConstant: 45),
            
            starBtn.topAnchor.constraint(equalTo: locationImage.topAnchor, constant: 40),
            starBtn.trailingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: -20),
            starBtn.heightAnchor.constraint(equalToConstant: 45),
            starBtn.widthAnchor.constraint(equalToConstant: 45),
            
            locationDetailView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            locationDetailView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            locationDetailView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            locationDetailView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.5),
        ])
    }
}
