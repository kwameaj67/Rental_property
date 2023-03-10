//
//  CustomTextField.swift
//  rental_property
//
//  Created by Kwame Agyenim Boateng on 3/10/23.
//

import UIKit


class CustomTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        borderStyle = .none
        layer.cornerRadius = 15
        textColor = .black
        backgroundColor = Color.grey
        font = custom(name: .medium, size: 18, style: .caption1)
        attributedPlaceholder = NSMutableAttributedString(string: "From",attributes: [.font: custom(name: .regular, size: 15, style: .headline),.foregroundColor: UIColor.systemGray3])
        layer.masksToBounds = true
        layer.borderWidth = 0.0
        autocorrectionType = .no
        autocapitalizationType = .none
        clearButtonMode = .whileEditing
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 20, dy: 0)
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 20, dy: 0)
    }
}
