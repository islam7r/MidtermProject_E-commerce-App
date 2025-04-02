//
//  ProductsInCartManager.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 01.04.25.
//

import UIKit


class ProductsInCartManager{
    
    static let shared = ProductsInCartManager()
    private var items: [ProductModel.ProductItemModel] = []
    
    func set(item: ProductModel.ProductItemModel){
        self.items.append(item)
    }
    
    func remove(item: ProductModel.ProductItemModel){
        if let itemIndex = self.items.firstIndex(where: { model in
            return  item.name == model.name
        }){
            self.items.remove(at: itemIndex)
        }
    }
    
    func getItems() -> [ProductModel.ProductItemModel]{
        return self.items
    }
    
}
