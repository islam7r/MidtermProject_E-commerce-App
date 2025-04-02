//
//  AddToCartViewController.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 22.03.25.
//

import UIKit

class AddToCartViewController: UIViewController{
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    
    var productModel: [ProductModel.ProductItemModel] = []
    
    
    var selectedIndexPath: IndexPath = [-1,-1]
    
    
    var productImageName: String = ""
    var productName: String = ""
    var productPrice: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productNameLabel.text = productName
        productPriceLabel.text = "\(productPrice) usd"
        productImageView.image = UIImage(named: productImageName)
        if let productModel = ProductManager.shared.decodeProduct(){
            self.productModel = productModel
        }
    }
    
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        productModel[selectedIndexPath.row].inCart = true
        print(UserManager.shared.getUser().first!)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            vc.selectedIndexPaths.append(selectedIndexPath)
            
            ProductsInCartManager.shared.set(item: productModel[selectedIndexPath.row])
            
            
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
