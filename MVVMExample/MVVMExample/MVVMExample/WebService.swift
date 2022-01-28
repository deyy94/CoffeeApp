//
//  WebService.swift
//  MVVMExample
//
//  Created by David Guillermo Robles Sánchez on 27/01/22.
//

import Foundation


class WebService{
    
    func getArticules(url: URL, completion: @escaping ([Articulo]?) -> ()){
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                print(error)
            }else if let data = data {
                do{
                    let articleList = try? JSONDecoder().decode( ArticuloLista.self, from: data)
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
