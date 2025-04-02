//
//  FavoriteManager.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 31.03.25.
//

import UIKit


class FavoriteManager{
    
    static let shared = FavoriteManager()
    private var items: [ProductModel.ProductItemModel] = []
    
    func set(item: ProductModel.ProductItemModel){
        var newItem = item
        newItem.isFavorite = true
        self.items.append(newItem)
       
    }
    
    func remove(item: ProductModel.ProductItemModel){
        if let itemIndex = self.items.firstIndex(where: { model in
            return model.name == item.name
        }){
            self.items[itemIndex].isFavorite = false
            self.items.remove(at: itemIndex)
             
        }
    }
    
    
    func getItems() -> [ProductModel.ProductItemModel]{
        return self.items
    }
}
