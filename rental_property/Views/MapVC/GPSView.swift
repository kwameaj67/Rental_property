//
//  GPSView.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/6/23.
//

import UIKit

protocol DidTapGPSDelegate: AnyObject {
    func didTapGPS()
}
class GPSView: UIView {
    
    weak var delegate: DidTapGPSDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 20
        
        // tap gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var gpsImage : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(named: "gps")?.withRenderingMode(.alwaysOriginal)
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    @objc func handleTap(){
        delegate?.didTapGPS()
    }
    func setupViews(){
        addSubview(gpsImage)
    }
    func setupConstraints(){
        gpsImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        gpsImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        gpsImage.widthAnchor.constraint(equalToConstant: 25).isActive = true
        gpsImage.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
}
