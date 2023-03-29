//
//  FilterVC.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/5/23.
//

import UIKit

class FilterVC: UIViewController {
    
    var guestNumber: Int = 1 {
        didSet{
            tableView.reloadData()
            filter.numberOfGuest = guestNumber
        }
    }
    
    var filter = FilterCondition(){
        didSet{
            print("PriceFrom: \(filter.priceFrom)\nPriceTo: \(filter.priceTo)\nPropertyType: \(filter.propertyType)\nGuests: \(filter.numberOfGuest)\nConveniences: \(filter.conveniences)")
        }
    }
    
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
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.backgroundColor = .none
        tv.estimatedRowHeight = UITableView.automaticDimension
//        tv.rowHeight = 200
        tv.register(PriceTableViewCell.self, forCellReuseIdentifier: PriceTableViewCell.reusableID)
        tv.register(ConvenienceTableViewCell.self, forCellReuseIdentifier: ConvenienceTableViewCell.reusableID)
        tv.register(GuestTableViewCell.self, forCellReuseIdentifier: GuestTableViewCell.reusableID)
        tv.register(FilterFooterView.self, forHeaderFooterViewReuseIdentifier: FilterFooterView.reusableID)
        tv.delegate = self
        tv.dataSource = self
        tv.allowsSelection = false
        tv.allowsMultipleSelection = false
        tv.showsVerticalScrollIndicator = false
        tv.separatorInset = .zero
        tv.separatorStyle = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
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
