//
//  BaseButton.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 20.03.25.
//

import UIKit

class BaseButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    private func setupButton() {
        backgroundColor = .black
        tintColor = .white
        layer.cornerRadius = 10
    }

}
