//
//  ConvenienceCollectionView.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/21/23.
//

import UIKit

class ConvenienceCollectionView: UIView {
    
    var features:[String] = []{
        didSet{
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .none
        
        //shadows
        layer.shadowColor = UIColor.white.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 30
        layer.shadowOffset = CGSize(width: 0, height: -10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = .init(top: 0, left: 25, bottom: 0, right: 25)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.setCollectionViewLayout(layout, animated: true)
        cv.register(FeatureCollectionViewCell.self, forCellWithReuseIdentifier: FeatureCollectionViewCell.reusableID)
        cv.backgroundColor = .none
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = false
        cv.isScrollEnabled = true
        cv.bounces = true
        cv.allowsSelection = true
        cv.allowsMultipleSelection = true
        cv.alwaysBounceHorizontal = true
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    func setupViews(){
        addSubview(collectionView)
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor,constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: 5),
        ])
    }
}


extension ConvenienceCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return features.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeatureCollectionViewCell.reusableID, for: indexPath) as? FeatureCollectionViewCell else {
            fatalError("Cannot dequeue cell")
        }
        cell.lbl.text = features[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 56)
    }
}
