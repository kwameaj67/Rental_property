//
//  SearchView.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/6/23.
//

import UIKit

protocol DidTapFilterButtonDelegate : AnyObject {
    func didTapFilterButton()
}
class SearchView: UIView {

    weak var delegate: DidTapFilterButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 20
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    lazy var searchBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleSearchDidTap), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var searchTextField : UITextField = {
        let tf = UITextField(frame: .zero)
        tf.placeholder = "Search property or location"
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.textColor = .black
        tf.font = custom(name: .medium, size: 17, style: .caption1)
        tf.inputAccessoryView = createToolBar()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var filterBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "setting")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleFilterDidTap), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    
    func setupViews(){
        [searchBtn,searchTextField,filterBtn].forEach { item in
            addSubview(item)
        }
    }
    func setupContraints(){
        NSLayoutConstraint.activate([
            searchBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchBtn.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            searchBtn.widthAnchor.constraint(equalToConstant: 20),
            searchBtn.heightAnchor.constraint(equalToConstant: 20),
            
            searchTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: searchBtn.trailingAnchor, constant: 8),
            searchTextField.trailingAnchor.constraint(equalTo: filterBtn.leadingAnchor, constant: -8),
            searchTextField.heightAnchor.constraint(equalToConstant: 35),
            
            filterBtn.centerYAnchor.constraint(equalTo: centerYAnchor),
            filterBtn.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            filterBtn.widthAnchor.constraint(equalToConstant: 20),
            filterBtn.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    @objc func handleFilterDidTap(){
        generateHapticTouch()
        delegate?.didTapFilterButton()
    }
    
    @objc func handleSearchDidTap(){
        searchTextField.becomeFirstResponder()
    }
}

// MARK: UIToolbar -
extension SearchView {
    func createToolBar() -> UIToolbar{
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let space1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let space2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let labelButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        labelButton.setTitle("Done", for: .normal)
        labelButton.setTitleColor(.black, for: .normal)
        labelButton.titleLabel?.font = custom(name: .medium, size: 18, style: .headline)
        labelButton.addTarget(self, action: #selector(onDone), for: .primaryActionTriggered)
        let doneBarItem = UIBarButtonItem(customView: labelButton)
        doneBarItem.tintColor = UIColor.black
        toolbar.setItems([space1,space2,doneBarItem], animated: true)
        return toolbar
    }
    
    @objc func onDone(){
        if searchTextField.isFirstResponder{
            searchTextField.resignFirstResponder()
        }
    }
}
