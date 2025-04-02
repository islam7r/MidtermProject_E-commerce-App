//
//  CategoryNameCollectionViewCell.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 23.03.25.
//

import UIKit

class CategoryNameCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var underLineView: UIView!
    @IBOutlet weak var mainView: UIView!
    var itemTapped: (() -> ())?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mainView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        mainView.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc private func handleTap(){
        self.itemTapped?()
    }

}

extension CategoryNameCollectionViewCell {
    struct item {
        let categroyName: String
        
    }
    
    func configure(_ item: item){
        self.categoryNameLabel.text = item.categroyName
        
    }
}


