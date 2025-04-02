//
//  ProductManager.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 23.03.25.
//

import Foundation


class ProductManager{
    static let shared = ProductManager()
    
    func decodeProduct() -> [ProductModel.ProductItemModel]?{
        if let url = Bundle.main.url(forResource: "products", withExtension: "json"){
            let decoder = JSONDecoder()
            do{
                let data = try Data(contentsOf: url)
                let jsonData = try decoder.decode(ProductModel.self, from: data)
                return jsonData.products
            }catch{
                print(error)
            }
        }
        return nil
    }
    
}
