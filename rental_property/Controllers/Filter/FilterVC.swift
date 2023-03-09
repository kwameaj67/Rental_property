//
//  FilterVC.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/5/23.
//

import UIKit

class FilterVC: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupContraints()
    }
    

    // MARK: Properties -
    lazy var headerView: FilterHeaderView = {
        let v = FilterHeaderView(frame: .zero)
        v.delegate = self
        return v
    }()

    func setupViews(){
        view.addSubview(headerView)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 75),
            
        ])
    }

}
