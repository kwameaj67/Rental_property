//
//  LocationCollectionView.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/18/23.
//

import UIKit
import CHIPageControl


class LocationCollectionView: UIView {
    
    var WIDTH_ANCHOR: CGFloat = 70.0
    
    var images: [String] = []{
        didSet{
            pageControl.numberOfPages = images.count
            imageCollectionView.reloadData()
            
            if images.count > 4 {
                pageControlView.widthAnchor.constraint(equalToConstant: WIDTH_ANCHOR + 25).isActive = true
            }
            else {
                pageControlView.widthAnchor.constraint(equalToConstant: WIDTH_ANCHOR).isActive = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContraints()
        translatesAutoresizingMaskIntoConstraints = false
        pageControl.set(progress: 0, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    lazy var imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.setCollectionViewLayout(layout, animated: true)
        cv.register(LocationImageCollectionViewCell.self, forCellWithReuseIdentifier: LocationImageCollectionViewCell.reusableID)
        cv.backgroundColor = .none
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        cv.isScrollEnabled = true
        cv.bounces = true
        cv.alwaysBounceHorizontal = true
        cv.showsHorizontalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    lazy var pageControl: CHIPageControlAleppo = {
        let pg = CHIPageControlAleppo(frame: .zero)
        pg.numberOfPages = 3
        pg.radius = 4
        pg.tintColor = .systemGray4
        pg.currentPageTintColor = .white
        pg.progress = 0.5
        pg.translatesAutoresizingMaskIntoConstraints = false
        pg.padding = 6
        return pg
    }()
    
    lazy var pageControlView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .black
        v.alpha = 0.4
        v.layer.cornerRadius = 34/2
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    func setupViews(){
        addSubview(imageCollectionView)
        addSubview(pageControlView)
        pageControlView.addSubview(pageControl)
        imageCollectionView.bringSubviewToFront(pageControlView)
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            imageCollectionView.topAnchor.constraint(equalTo: topAnchor),
            imageCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            pageControlView.bottomAnchor.constraint(equalTo: imageCollectionView.bottomAnchor, constant: -100),
            pageControlView.centerXAnchor.constraint(equalTo: imageCollectionView.centerXAnchor),
            pageControlView.heightAnchor.constraint(equalToConstant: 34),
            
            pageControl.centerYAnchor.constraint(equalTo: pageControlView.centerYAnchor),
            pageControl.centerXAnchor.constraint(equalTo: pageControlView.centerXAnchor),
        ])
        
    }
}


extension LocationCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationImageCollectionViewCell.reusableID, for: indexPath) as? LocationImageCollectionViewCell else {
            fatalError("Cannot dequeue cell")
        }
        let imageName = images[indexPath.row]
        cell.locationImage.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(00)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.set(progress: Int( x / imageCollectionView.frame.width), animated: true)
    }
    
    
}
