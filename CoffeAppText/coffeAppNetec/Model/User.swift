//
//  User.swift
//  coffeAppNetec
//
//  Created by Arlen Peña on 03/09/20.
//  Copyright © 2020 Arlen Peña. All rights reserved.
//

import Foundation

struct User {
    var name: String
    var password : String
    var email : String
    init(name:String, password:String, email:String) {
        self.name = name
        self.password = password
        self.email = email
    }
}
