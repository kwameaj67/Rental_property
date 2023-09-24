//
//  ConvenienceTableViewCell.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/10/23.
//

import UIKit
import Combine
import AlignedCollectionViewFlowLayout

protocol ConvenienceTableViewCellDelegate: AnyObject {
    func selectConvenience(item: String)
}

class ConvenienceTableViewCell: UITableViewCell {

    var conveniences = [String]()
    
    weak var delegate: ConvenienceTableViewCellDelegate?
    
    static let reusableID = "ConvenienceTableViewCell"
    
    let features:[Feature] = Feature.data
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: ConvenienceTableViewCell.reusableID)
        setupViews()
        setupContraints()
        backgroundColor = .white
        
        // selects first item
        // collectionView.selectItem(at: .init(row: 0, section: 0), animated: true, scrollPosition: .top)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    lazy var headingLbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "Conveniences"
        lbl.textColor = .black
        lbl.font = custom(name: .bold, size: 20, style: .caption1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var collectionView: UICollectionView = {
        let alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment: .left, verticalAlignment: .top)
        alignedFlowLayout.horizontalAlignment = .left
        alignedFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        alignedFlowLayout.minimumLineSpacing = 12
        alignedFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let cv = UICollectionView(frame: .zero, collectionViewLayout: alignedFlowLayout)
        cv.register(FeatureCollectionViewCell.self, forCellWithReuseIdentifier: FeatureCollectionViewCell.reusableID)
        cv.backgroundColor = .none
        cv.delegate = self
        cv.dataSource = self
        cv.allowsSelection = true
        cv.allowsMultipleSelection = true
        cv.isUserInteractionEnabled = true
        cv.bounces = true
        cv.isScrollEnabled = false
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    func setupViews(){
        contentView.addSubview(headingLbl)
        contentView.addSubview(collectionView)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            headingLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            headingLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            headingLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: headingLbl.bottomAnchor,constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}


extension ConvenienceTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return features.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeatureCollectionViewCell.reusableID, for: indexPath) as? FeatureCollectionViewCell else {
            fatalError("Cannot dequeue cell")
        }
        cell.data = features[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        generateHapticTouch()
        let _ = collectionView.cellForItem(at: indexPath) as! FeatureCollectionViewCell
        let item = features[indexPath.row]
        delegate?.selectConvenience(item: item.name)
    }
}
