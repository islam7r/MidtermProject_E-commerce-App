//
//  BaseTextField.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 20.03.25.
//

import UIKit

class BaseTextField: UITextField {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 10
        clipsToBounds = true
        backgroundColor = UIColor(named: "textFieldBgColor")
        
        tintColor = UIColor(named: "textFieldPlaceholderColor")
        
        if let placeholderText = placeholder{
            attributedPlaceholder = NSAttributedString(
                string: placeholderText,
                attributes: [
                    .foregroundColor: UIColor(named: "textFieldPlaceholderColor") ?? UIColor.black,
                    .font: UIFont.systemFont(ofSize: 15, weight: .regular)
                    
                ]
            )
        }
        
        
        
    }
}
