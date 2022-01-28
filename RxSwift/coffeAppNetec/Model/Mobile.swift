//
//  Mobile.swift
//  coffeAppNetec
//
//  Created by David Guillermo Robles Sánchez on 26/01/22.
//  Copyright © 2022 Arlen Peña. All rights reserved.
//

import Foundation

struct Mobile: Codable{
    var id : Int
    var name : String
    var thumbnail : String
    var age : Int
    var weight : Double
    var height : Double
    var hair_color : String
    
  init(id:Int,name : String, thumbnail : String, age : Int, weight : Double, height: Double, hair_color : String) {
        self.id = id
        self.name = name
        self.thumbnail = thumbnail
        self.age = age
        self.weight = weight
        self.height = height
        self.hair_color = hair_color
    }
}

struct ArrayMobile: Codable{
    var Brastlewark: [Mobile]
    init(Brastlewark: [Mobile]){
        self.Brastlewark = Brastlewark
    }
}


