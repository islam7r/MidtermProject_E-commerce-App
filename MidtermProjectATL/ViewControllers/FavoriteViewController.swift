//
//  FavoriteViewController.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 31.03.25.
//

import UIKit

class FavoriteViewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
    let emptyLayout = UICollectionViewFlowLayout()
    
    var productModel: [ProductModel.ProductItemModel] = []
   
    var productCell = UITableViewCell() as? ProductsTableViewCell
    
    var selectedIndexPath: IndexPath = [-1,-1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductsCollectionViewCell.nib, forCellWithReuseIdentifier: ProductsCollectionViewCell.reuseIdentifier)
        collectionView.register(IsEmptyCollectionViewCell.nib, forCellWithReuseIdentifier: IsEmptyCollectionViewCell.reuseIdentifier)
        
        emptyLayout.scrollDirection = .vertical
        emptyLayout.itemSize = .init(width: collectionView.frame.width, height: collectionView.frame.height / 2)
        emptyLayout.sectionInset = .init(top: 0, left: 24, bottom: 0, right: 24)
        
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: collectionView.frame.width / 2 - 8, height: collectionView.frame.height / 3 - 15)
        layout.sectionInset = .init(top: 0, left: 24, bottom: 0, right: 24)
        
        if FavoriteManager.shared.getItems().count == 0{
            
            collectionView.collectionViewLayout = emptyLayout
        }else{
            
            collectionView.collectionViewLayout = layout
        }
        
        if let productModel = ProductManager.shared.decodeProduct(){
            self.productModel = productModel
        }
        collectionView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        if FavoriteManager.shared.getItems().count == 0{
            collectionView.collectionViewLayout = emptyLayout
        }else{
            collectionView.collectionViewLayout = layout
        }
    }
    
}

extension FavoriteViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if FavoriteManager.shared.getItems().count == 0{
            return 1
        }
        return FavoriteManager.shared.getItems().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if FavoriteManager.shared.getItems().count == 0{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IsEmptyCollectionViewCell.reuseIdentifier, for: indexPath) as? IsEmptyCollectionViewCell else{return UICollectionViewCell()}
            
            cell.bgView.layer.cornerRadius = 10
            cell.imageView.image = UIImage(systemName: "heart.fill")
            cell.imageView.tintColor = .systemRed
            cell.messageLabel.text = "No favorites yet. Start adding some!"
            
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCollectionViewCell.reuseIdentifier, for: indexPath) as? ProductsCollectionViewCell else{return UICollectionViewCell()}
        var item = FavoriteManager.shared.getItems()[indexPath.row]
        
        cell.isFavorite = item.isFavorite
        cell.setupUI()
        cell.configure(item)
        
       
        
        
        
        
        
        cell.favoriteImageTappedInFVC = {
            
            cell.isFavorite = false
            self.productModel[indexPath.row].isFavorite = false
            FavoriteManager.shared.remove(item:  item)
            print(item.isFavorite)
            
            print(FavoriteManager.shared.getItems(), "favorite")
            print("----------------------------------------------")
            if FavoriteManager.shared.getItems().count == 0{
                collectionView.collectionViewLayout = self.emptyLayout
            }else{
                collectionView.collectionViewLayout = self.layout
            }
            cell.setupUI()
            self.productCell?.collectionView.reloadData()
            collectionView.reloadData()
        }
        return cell
    }
}


extension FavoriteViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ProductsCollectionViewCell {
            
            if let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "AddToCartViewController") as? AddToCartViewController {
                
                var item = FavoriteManager.shared.getItems()[indexPath.row]
                vc.selectedIndexPath = indexPath
                vc.productImageName = item.imageName
                vc.productName = item.name
                vc.productPrice = String(item.price)
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
