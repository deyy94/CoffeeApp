//
//  WebService.swift
//  VIPERExample
//
//  Created by David Guillermo Robles Sánchez on 27/01/22.
//

import Foundation

class WebService{
    func getArticles(url: URL, completion: @escaping([Article]?) -> ()){
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                print(error)
            }else if let data = data {
                do{
                    let articleList = try? JSONDecoder().decode( ArticleList.self, from: data)
                    if let articleList = articleList{
                        completion(articleList.articles)
                    }
                }
                catch{
                    print(error)
                }
            }
        }
    }
}
