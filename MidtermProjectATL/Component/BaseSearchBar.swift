//
//  BaseSearchBar.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 20.03.25.
//

import UIKit

class BaseSearchBar: UITextField {
    
    private let leftViewIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = .systemYellow
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemYellow.cgColor
        layer.cornerRadius = 15
        clipsToBounds = true
        
        let attributedString = NSAttributedString(string: "Search", attributes: [.foregroundColor: UIColor.systemYellow])
        attributedPlaceholder = attributedString
        
        let leftViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 32))
        leftViewIcon.frame = CGRect(x: 10, y: 8, width: 16, height: 16)
        leftViewContainer.addSubview(leftViewIcon)
        
        leftView = leftViewContainer
        leftViewMode = .always
    }
}
