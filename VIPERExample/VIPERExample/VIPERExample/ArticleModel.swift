//
//  ArticleModel.swift
//  VIPERExample
//
//  Created by David Guillermo Robles Sánchez on 27/01/22.
//

import Foundation

struct ArticleList: Decodable{
    let articles: [Article]
}
struct Article: Decodable{
    let title: String?
    let description: String?
}
