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
    
    lazy var tableView : UITableView = {
        let tb = UITableView()
        tb.backgroundColor = .none
        tb.register(PriceTableViewCell.self, forCellReuseIdentifier: PriceTableViewCell.reusableID)
        tb.delegate = self
        tb.dataSource = self
        tb.allowsSelection = false
        tb.allowsMultipleSelection = false
        tb.separatorInset = .zero
        tb.separatorStyle = .none
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    func setupViews(){
        view.addSubview(headerView)
        view.addSubview(tableView)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 75),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
