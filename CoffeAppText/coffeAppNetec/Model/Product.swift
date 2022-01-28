//
//  Product.swift
//  coffeAppNetec
//
//  Created by Arlen Peña on 03/09/20.
//  Copyright © 2020 Arlen Peña. All rights reserved.
//

import Foundation

enum Category : Int{
    case drink
    case dessert
    case sandwich
    case none
    func numeration() -> Int{
        switch self {
        case .drink:
            return 0
        case .dessert:
            return 1
        case .sandwich:
            return 2
        case .none:
            return 3
        }
    }
}


enum SizeProduct{
    case small
    case medium
    case large
    case unique
}

struct Product {
    var name : String
    var description : String
    var category : Category
    var price : String
    var size : SizeProduct
    var favorite : Bool
    var quantity : Int
    var img : String
    
  init(name:String,description : String, category : Category, price : String, size :SizeProduct, favorite: Bool, quantity : Int, img:String) {
        self.name = name
        self.description = description
        self.category = category
        self.price = price
        self.size = size
        self.favorite = favorite
        self.quantity = quantity
        self.img = img
    }
}


