//
//  Articulo.swift
//  MVVMExample
//
//  Created by David Guillermo Robles Sánchez on 27/01/22.
//

import Foundation


struct ArticuloLista: Decodable{
    var articles: [Articulo]
}
struct Articulo: Decodable{
    let title: String?
    let description: String?
}
