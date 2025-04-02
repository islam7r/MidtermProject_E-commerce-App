//
//  ProductsTableViewCell.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 22.03.25.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {
    
    private var items: [ProductModel.ProductItemModel] = []
    var navigationController: UINavigationController? = nil
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isFavorite: Bool = false
    var favoriteProductIndexPath: IndexPath? = nil
    var favoriteProductIndexPaths: [IndexPath] = []
    
    var productModel: [ProductModel.ProductItemModel] = []
    let products = ProductManager.shared.decodeProduct()
    
    var cell: ProductsCollectionViewCell = ProductsCollectionViewCell()
    let layout = UICollectionViewFlowLayout()
    
    var itemTapped: (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductsCollectionViewCell.nib, forCellWithReuseIdentifier: ProductsCollectionViewCell.reuseIdentifier)
        
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 0, left: 24, bottom: 0, right: 24)
        collectionView.collectionViewLayout = layout
        if let productModel = ProductManager.shared.decodeProduct(){
            self.productModel = productModel
        }
        collectionView.reloadData()
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout.itemSize = .init(width: collectionView.frame.width / 2 - 48, height: collectionView.frame.height / 2 - 15 )
        collectionView.reloadData()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}

extension ProductsTableViewCell{
    struct item{
        var items: [ProductModel.ProductItemModel] = []
        
    }
    
    func configure(_ item: ProductModel.ProductItemModel){
        self.items = [item]
    }
}


extension ProductsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productModel.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCollectionViewCell.reuseIdentifier, for: indexPath) as? ProductsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        
        cell.isFavorite = productModel[indexPath.row].isFavorite
        cell.setupUI()
        cell.configure(productModel[indexPath.row])
        

        
        
        self.cell = cell
        
        cell.favoriteImageTapped = {
            
            self.productModel[indexPath.row].isFavorite.toggle()
            
            if self.productModel[indexPath.row].isFavorite{
                FavoriteManager.shared.set(item:  self.productModel[indexPath.row])
            }else{
                FavoriteManager.shared.remove(item:  self.productModel[indexPath.row])
            }
            cell.setupUI()

            
            collectionView.reloadData()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ProductsCollectionViewCell {
            print(indexPath.row)
            print("cell selected")
            if let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "AddToCartViewController") as? AddToCartViewController {
                
                var item = productModel[indexPath.row]
                vc.selectedIndexPath = indexPath
                vc.productImageName = item.imageName
                vc.productName = item.name
                vc.productPrice = String(item.price)
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

