//
//  ProductsCollectionViewCell.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 22.03.25.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var bigRoundedView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var favoriteImageBgView: UIView!
    
    var favoriteImageTapped: (() -> Void)?
    var favoriteImageTappedInFVC: (() -> Void)?
    var isFavorite: Bool = false
    
    var productModel: [ProductModel.ProductItemModel] = []
    

    override func awakeFromNib() {
        super.awakeFromNib()
        favoriteImageBgView.isUserInteractionEnabled = true
        let favoriteImageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(favoriteImageTappedHandler))
        favoriteImageBgView.addGestureRecognizer(favoriteImageTapGestureRecognizer)
        setupUI()
    }
    
    @objc func favoriteImageTappedHandler() {
        favoriteImageTapped?()
        favoriteImageTappedInFVC?()
    }
    func setupUI(){
        if isFavorite {
            favoriteImage.image = UIImage(systemName: "heart.fill")
        }else{
            favoriteImage.image = UIImage(systemName: "heart")
        }
    }

}



extension ProductsCollectionViewCell {
    
    func configure(_ item: ProductModel.ProductItemModel){
        roundedView.layer.cornerRadius = 15
        roundedView.clipsToBounds = true

        bigRoundedView.layer.cornerRadius = 20
        bigRoundedView.clipsToBounds = true
        bigRoundedView.layer.borderWidth = 1
        bigRoundedView.layer.borderColor = UIColor.systemYellow.cgColor

        productImageView.image = UIImage(named: item.imageName)
        productNameLabel.text = item.name
        productPriceLabel.text = "\(item.price) usd"

        setupUI()

        favoriteImageBgView.layer.cornerRadius = favoriteImageBgView.frame.height / 2
        favoriteImageBgView.clipsToBounds = true
        
        if let productModel = ProductManager.shared.decodeProduct(){
            self.productModel = productModel
        }
    }
    
    
    
}
