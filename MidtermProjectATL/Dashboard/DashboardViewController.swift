//
//  DashboardViewController.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 20.03.25.
//

import UIKit

class DashboardViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    var favoriteProductIndexPath: IndexPath? = nil
    var favoriteProductIndexPaths: [IndexPath] = []
    
    var productModel: [ProductModel.ProductItemModel] = [
        
    ]
    
    var productCell = UITableViewCell() as? ProductsTableViewCell
    
    let products = ProductManager.shared.decodeProduct()
    var numOfProducts: Int = 0
    
    enum cellType{
        case category(CategoryTableViewCell.item)
        case banner(BannerTableViewCell.item)
        case product([ProductModel.ProductItemModel])
    }
    private var cellModel: [cellType] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CategoryTableViewCell.nib, forCellReuseIdentifier: CategoryTableViewCell.reuseIdentifier)
        tableView.register(BannerTableViewCell.nib, forCellReuseIdentifier: BannerTableViewCell.reuseIdentifier)
        tableView.register(ProductsTableViewCell.nib, forCellReuseIdentifier: ProductsTableViewCell.reuseIdentifier)
        
        numOfProducts = products?.count ?? 0
        
        loadData()
        
        if let productModel = ProductManager.shared.decodeProduct(){
            
            for num in productModel{
                self.productModel.append(num)
                print(num, "num")
            }
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productCell?.collectionView.reloadData()
    }
    
    private func loadData(){
        
        cellModel = [
            .category(.init(items: [
                .init(categoryName: "Vegetables", imageName: "vegetables", bgColorName: "categoryColor1"),
                .init(categoryName: "Fruit", imageName: "fruit", bgColorName: "categoryColor2"),
                .init(categoryName: "Spice", imageName: "spice", bgColorName: "categoryColor3"),
                .init(categoryName: "Ingridients", imageName: "ingridient", bgColorName: "categoryColor3"),
                .init(categoryName: "Side Dishes", imageName: "sideDishes", bgColorName: "categoryColor3"),
                .init(categoryName: "Fruit", imageName: "fruit", bgColorName: "categoryColor2"),
                .init(categoryName: "Side Dishes", imageName: "sideDishes", bgColorName: "categoryColor3"),
                .init(categoryName: "Side Dishes", imageName: "sideDishes", bgColorName: "categoryColor3"),
                
            ])),
            .banner(.init(items: [
                .init(hashTag: "#SimpleKitchen", imageName: "soup", title: "Soup Package", subtitle: "No need to think about ingredients anymore, let's find your menu today")
            ])),
            .product(self.productModel)
                
            
        ]
        
        tableView.reloadData()
    }
    
    
}

extension DashboardViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellType = cellModel[indexPath.row]
        
        switch cellType{
        case.category(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reuseIdentifier, for: indexPath) as? CategoryTableViewCell else { return UITableViewCell() }
            cell.configure(model)
            cell.showAllTapped = {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CategoryViewController") as? CategoryViewController{
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            return cell
        case .banner(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.reuseIdentifier, for: indexPath) as? BannerTableViewCell else { return UITableViewCell() }
            cell.configure(model)
            return cell
        case .product(let products):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductsTableViewCell.reuseIdentifier, for: indexPath) as? ProductsTableViewCell else { return UITableViewCell() }
            for num in self.productModel{
                var newIndexPathRow = indexPath.row
                cell.configure(self.productModel[newIndexPathRow])
                newIndexPathRow += 1
                print(self.productModel[indexPath.row])
            }
            
            print(self.productModel[indexPath.row], "outside")
            cell.navigationController = self.navigationController
            
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellType = cellModel[indexPath.row]
        
        switch cellType{
        case.category(_):
            return 110
        case .banner(_):
            return 180
        case .product(_):
            return 400
        }
    }
}

extension DashboardViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
