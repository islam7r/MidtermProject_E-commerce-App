//
//  CartViewController.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 29.03.25.
//

import UIKit

class CartViewController: UIViewController{
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    let layout = UICollectionViewFlowLayout()
    
    var selectedIndexPaths: [IndexPath] = []
    
    var totalPrice: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productCollectionView.delegate = self
        productCollectionView.dataSource = self
        productCollectionView.register(ProductInCartCollectionViewCell.nib, forCellWithReuseIdentifier: ProductInCartCollectionViewCell.reuseIdentifier)
        productCollectionView.register(IsEmptyCollectionViewCell.nib, forCellWithReuseIdentifier: IsEmptyCollectionViewCell.reuseIdentifier)
        
        layout.itemSize = .init(width: productCollectionView.frame.width, height: productCollectionView.frame.height / 2 - 8)
        layout.sectionInset = .init(top: 10, left: 16, bottom: 10, right: 16)
        productCollectionView.collectionViewLayout = layout
        
        totalPriceLabel.text = "\(totalPrice) $"
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        totalPrice = 0
        for item in ProductsInCartManager.shared.getItems() {
            totalPrice += item.price
        }
        totalPriceLabel.text = "\(totalPrice) $"
        productCollectionView.reloadData()
    }
}

extension CartViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if ProductsInCartManager.shared.getItems().count == 0{
            return 1
        }
        return ProductsInCartManager.shared.getItems().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if ProductsInCartManager.shared.getItems().count == 0{
            guard let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: IsEmptyCollectionViewCell.reuseIdentifier, for: indexPath) as? IsEmptyCollectionViewCell else{return UICollectionViewCell()}
            cell.bgView.layer.cornerRadius = 10
            cell.imageView.image = UIImage(systemName: "cart.fill")
            cell.messageLabel.text = "Cart is empty. Add some products!"
            return cell
        }
        guard let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: ProductInCartCollectionViewCell.reuseIdentifier, for: indexPath) as? ProductInCartCollectionViewCell else{return UICollectionViewCell()}
        
        var items = ProductsInCartManager.shared.getItems()[indexPath.row]
        
        cell.removeProductAction = {
            
            UIView.animate(withDuration: 0.3) {
                cell.alpha = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                ProductsInCartManager.shared.remove(item: items)
                self.totalPrice -= items.price
                self.totalPriceLabel.text = "\(self.totalPrice) $"
                self.productCollectionView.reloadData()
            })
            
            
        }
        cell.configure(items)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(selectedIndexPaths, "selectedIndexPaths")
        
    
    }
    
    
}
