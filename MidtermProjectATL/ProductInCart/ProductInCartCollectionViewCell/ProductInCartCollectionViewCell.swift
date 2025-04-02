//
//  ProductInCartCollectionViewCell.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 29.03.25.
//

import UIKit

class ProductInCartCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    var removeProductAction: (() -> ())?
    
    var productModel: [ ProductModel.ProductItemModel] = [
        
    ]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func configure(_ item: ProductModel.ProductItemModel){
        
        productImageView.layer.cornerRadius = 8
        productImageView.layer.masksToBounds = true
        productImageView.layer.borderWidth = 1
        productImageView.layer.borderColor = UIColor.systemOrange.cgColor
        
        productImageView.image = UIImage(named: item.imageName)
        productNameLabel.text = item.name
        productPriceLabel.text = "\(item.price) usd"
        
        
    }
    
    @IBAction func removeProductButtonTapped(_ sender: Any) {
        removeProductAction?()
    }

}




