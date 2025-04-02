//
//  CategoryCollectionViewCell.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 20.03.25.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension CategoryCollectionViewCell{
    
    struct item{
        let categoryName: String
        let imageName: String
        let bgColorName: String
    }
    
    func configure(_ item: item){
        containerView.layer.cornerRadius = 15
        containerView.clipsToBounds = true
        categoryLabel.text = item.categoryName
        categoryImageView.image = UIImage(named: item.imageName)
        containerView.backgroundColor = UIColor(named: item.bgColorName)
    }
}


