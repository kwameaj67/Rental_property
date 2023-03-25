//
//  PriceTableViewCell.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/10/23.
//

import UIKit

protocol PriceTableViewCellDelegate: AnyObject {
    func onChangeText(priceFrom: Double, priceTo: Double, propertyType: String)
}

class PriceTableViewCell: UITableViewCell {
        
    weak var delegate: PriceTableViewCellDelegate?
        
    static let reusableID = "PriceTableViewCell"
    
    let propertyTypes: [String] = ["Single-detached houses","Semi-detached houses", "Row houses", "Condominium apartments", "Mobile homes", "Other property types", "Properties with multiple residential units"]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: PriceTableViewCell.reusableID)
        setupViews()
        setupContraints()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties -
    lazy var headingLbl: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.text = "Price"
        lbl.textColor = .black
        lbl.font = custom(name: .bold, size: 20, style: .caption1)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    lazy var textFieldStackView: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.spacing = 10
        sv.axis = .horizontal
        sv.backgroundColor = .none
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var fromTextField : CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "From"
        tf.delegate = self
        tf.keyboardType = .numberPad
        tf.inputAccessoryView = createToolBar()
        return tf
    }()
    
    lazy var toTextField : CustomTextField = {
        let tf = CustomTextField()
        tf.placeholder = "To"
        tf.delegate = self
        tf.keyboardType = .numberPad
        tf.inputAccessoryView = createToolBar()
        return tf
    }()
    
    lazy var propertyView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = Color.grey
        v.layer.cornerRadius = 15
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var propertyTextField : UITextField = {
        let tf = UITextField()
        tf.textColor = .black
        tf.text = "Select property type"
        tf.font = custom(name: .regular, size: 16, style: .caption1)
        tf.attributedPlaceholder = NSMutableAttributedString(string: "Property Type",attributes: [.font: custom(name: .regular, size: 15, style: .headline),.foregroundColor: UIColor.systemGray3])
        tf.delegate = self
        tf.inputView = propertyPickerView
        tf.inputAccessoryView = createToolBar()
        tf.backgroundColor = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    lazy var propertyIcon : UIImageView = {
        var iv = UIImageView()
        iv.image = UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysTemplate).withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
        iv.tintColor = .black
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    lazy var propertyPickerView : UIPickerView = {
        let pv = UIPickerView(frame: .zero)
        pv.delegate = self
        pv.dataSource = self
        pv.layer.backgroundColor = UIColor.white.cgColor
        return pv
    }()

    func setupViews(){
        contentView.addSubview(headingLbl)
        contentView.addSubview(textFieldStackView)
        textFieldStackView.addArrangedSubview(fromTextField)
        textFieldStackView.addArrangedSubview(toTextField)
        contentView.addSubview(propertyView)
        propertyView.addSubview(propertyTextField)
        propertyView.addSubview(propertyIcon)
    }
    
    func setupContraints(){
        NSLayoutConstraint.activate([
            headingLbl.topAnchor.constraint(equalTo: contentView.topAnchor),
            headingLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            headingLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            textFieldStackView.topAnchor.constraint(equalTo: headingLbl.bottomAnchor, constant: 15),
            textFieldStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textFieldStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            textFieldStackView.heightAnchor.constraint(equalToConstant: 60),
            
            fromTextField.heightAnchor.constraint(equalTo: textFieldStackView.heightAnchor),
            toTextField.heightAnchor.constraint(equalTo: textFieldStackView.heightAnchor),
            
            propertyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            propertyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            propertyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            propertyView.heightAnchor.constraint(equalToConstant: 60),
            
            propertyTextField.leadingAnchor.constraint(equalTo: propertyView.leadingAnchor, constant: 20),
            propertyTextField.trailingAnchor.constraint(equalTo: propertyIcon.leadingAnchor,constant: -10),
            propertyTextField.heightAnchor.constraint(equalToConstant: 60),
            
            propertyIcon.centerYAnchor.constraint(equalTo: propertyView.centerYAnchor),
            propertyIcon.widthAnchor.constraint(equalToConstant: 16),
            propertyIcon.heightAnchor.constraint(equalToConstant: 16),
            propertyIcon.trailingAnchor.constraint(equalTo: propertyView.trailingAnchor, constant: -20),
        ])
    }
}


extension PriceTableViewCell {
    func createToolBar() -> UIToolbar{
        lazy var toolbar = UIToolbar()
        toolbar.sizeToFit()
        let space1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let space2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let labelButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
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
        generateHapticTouch()
        if fromTextField.isFirstResponder{
            fromTextField.resignFirstResponder()
        }
        else if toTextField.isFirstResponder{
            toTextField.resignFirstResponder()
        }
        else if propertyTextField.isFirstResponder{
            propertyTextField.resignFirstResponder()
        }
    }

}


// MARK: UIPickerViewDelegate, UIPickerViewDataSource -
extension PriceTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return propertyTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return propertyTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
        propertyTextField.text = propertyTypes[row]
        propertyTextField.resignFirstResponder()
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textColor = .black
        pickerLabel.text = propertyTypes[row]
        pickerLabel.font = custom(name: .medium, size: 18, style: .caption1)
        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }
    
}

// MARK: UITextFieldDelegate -
extension PriceTableViewCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let priceFrom = fromTextField.text, let priceTo = toTextField.text, let propertyType = propertyTextField.text  else { return }
        
        delegate?.onChangeText(priceFrom: (priceFrom as NSString).doubleValue, priceTo: (priceTo as NSString).doubleValue, propertyType: propertyType)
    }
}
