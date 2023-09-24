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
    
    var property_type_data = PropertyType.propertyTypes
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupContraints()
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandler(_:)))
        view.addGestureRecognizer(gestureRecognizer)
    }
    

    // MARK: Properties -
    lazy var headerView: FilterHeaderView = {
        let v = FilterHeaderView(frame: .zero)
        v.delegate = self
        return v
    }()
    
    lazy var tableView : UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.backgroundColor = .none
        tv.estimatedRowHeight = UITableView.automaticDimension
        tv.register(PriceTableViewCell.self, forCellReuseIdentifier: PriceTableViewCell.reusableID)
        tv.register(ConvenienceTableViewCell.self, forCellReuseIdentifier: ConvenienceTableViewCell.reusableID)
        tv.register(GuestTableViewCell.self, forCellReuseIdentifier: GuestTableViewCell.reusableID)
        tv.delegate = self
        tv.dataSource = self
        tv.allowsSelection = false
        tv.allowsMultipleSelection = false
        tv.showsVerticalScrollIndicator = false
        tv.separatorInset = .zero
        tv.separatorStyle = .none
        tv.tableHeaderView = UIView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    lazy var applyView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var border: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = UIColor.systemGray6
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()


    lazy var applyBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Apply", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = custom(name: .semi_bold, size: 18, style: .caption1)
        btn.backgroundColor = Color.black
        btn.addTarget(self, action: #selector(didTapApplyBtn), for: .touchUpInside)
        btn.layer.cornerRadius = 20
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    func setupViews(){
        view.addSubview(headerView)
        view.addSubview(tableView)
        view.addSubview(applyView)
        applyView.addSubview(border)
        applyView.addSubview(applyBtn)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            applyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            applyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            applyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            applyView.heightAnchor.constraint(equalToConstant: 70),
            
            border.topAnchor.constraint(equalTo: applyView.topAnchor),
            border.leadingAnchor.constraint(equalTo: applyView.leadingAnchor),
            border.trailingAnchor.constraint(equalTo: applyView.trailingAnchor),
            border.heightAnchor.constraint(equalToConstant: 1.5),
            
            applyBtn.topAnchor.constraint(equalTo: border.bottomAnchor, constant: 12),
            applyBtn.leadingAnchor.constraint(equalTo: border.leadingAnchor, constant: 20),
            applyBtn.trailingAnchor.constraint(equalTo: border.trailingAnchor, constant: -20),
            applyBtn.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
