//
//  ProductModel.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 23.03.25.
//

import Foundation


struct ProductModel: Decodable{
    var products: [ProductItemModel]
    struct ProductItemModel: Decodable{
        var name: String
        var price: Double
        var imageName: String
        var category: String
        var isFavorite: Bool
        var inCart: Bool
    }
}
