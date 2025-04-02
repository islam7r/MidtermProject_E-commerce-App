//
//  CategoryViewController.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 21.03.25.
//

import UIKit

class CategoryViewController: UIViewController{
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    var selectedCategoryIndexPath: IndexPath = IndexPath(row: -1, section: -1)
    var isCategorySelected: Bool = false
    
    private var categories: [CategoryNameCollectionViewCell.item] = [
        .init(categroyName: "All Category"),
        .init(categroyName: "Popular"),
        .init(categroyName: "Best Price"),
        .init(categroyName: "Best Deal"),
        .init(categroyName: "Package"),
        .init(categroyName: "All Category"),
    ]
    var productModel: [ProductModel.ProductItemModel] = [
        
    ]
    let categoryLayout = UICollectionViewFlowLayout()
    let productLayout = UICollectionViewFlowLayout()
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(CategoryNameCollectionViewCell.nib, forCellWithReuseIdentifier: CategoryNameCollectionViewCell.reuseIdentifier)
        
        
        categoryLayout.scrollDirection = .horizontal
        categoryLayout.estimatedItemSize = .init(width: categoryCollectionView.frame.width / 4 , height: categoryCollectionView.frame.height )
        categoryLayout.sectionInset = .init(top: 0, left: 24, bottom: 0, right: 24)
        categoryCollectionView.collectionViewLayout = categoryLayout
        categoryCollectionView.showsHorizontalScrollIndicator = false
        
        
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        productCollectionView.register(ProductsCollectionViewCell.nib, forCellWithReuseIdentifier: ProductsCollectionViewCell.reuseIdentifier)
        
        productLayout.scrollDirection = .vertical
        productLayout.itemSize = .init(width: productCollectionView.frame.width / 2 - 10, height: productCollectionView.frame.height / 3.5)
        productLayout.sectionInset = .init(top: 10, left: 24, bottom: 10, right: 24)
        productCollectionView.collectionViewLayout = productLayout
        
        if let productModel = ProductManager.shared.decodeProduct(){
            self.productModel = productModel
        }
        
    }
}

extension CategoryViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView{
            return self.categories.count
        }
        return self.productModel.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView{
            guard let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: CategoryNameCollectionViewCell.reuseIdentifier, for: indexPath) as? CategoryNameCollectionViewCell else{return UICollectionViewCell()}
            cell.configure(self.categories[indexPath.row])
            cell.itemTapped = {
                self.isCategorySelected.toggle()
                
                
                if self.selectedCategoryIndexPath == IndexPath(row: -1, section: -1){
                        self.selectedCategoryIndexPath = indexPath
                        if self.isCategorySelected{
                            cell.categoryNameLabel.textColor = .systemBlue
                            cell.underLineView.alpha = 1
                        }else{
                                
                        }
                    }else{
                        self.selectedCategoryIndexPath = IndexPath(row: -1, section: -1)
                        cell.categoryNameLabel.textColor = .black
                        cell.underLineView.alpha = 0
                    }
                
            }
            
            return cell
        }else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCollectionViewCell.reuseIdentifier, for: indexPath) as? ProductsCollectionViewCell else{return UICollectionViewCell()}
            cell.configure(productModel[indexPath.row])
            cell.isFavorite = productModel[indexPath.row].isFavorite

            cell.setupUI()
            
            cell.favoriteImageTapped = {
                
                self.productModel[indexPath.row].isFavorite.toggle()
                
                if self.productModel[indexPath.row].isFavorite{
                    FavoriteManager.shared.set(item:  self.productModel[indexPath.row])
                }else{
                    FavoriteManager.shared.remove(item:  self.productModel[indexPath.row])
                }
                print(FavoriteManager.shared.getItems(), "favorite")
                print("----------------------------------------------")
                cell.setupUI()

                
                collectionView.reloadData()
            }

            return cell
            
            return cell
        }
    }
}

extension CategoryViewController: UICollectionViewDelegate{
    
}
