//
//  ArticleListViewModel.swift
//  MVVMExample
//
//  Created by David Guillermo Robles Sánchez on 27/01/22.
//

import Foundation



struct ArticleListViewModel{
    let articles: [Articulo]
    
}
//Extension - Metodos del modelo de vista
extension ArticleListViewModel{
    
    //Variable para especificar las secciones de la tabla
    var numberOfSection: Int {
        return 1
    }
    
    //Metodo para retornar el numero de celdas en cada seccion
    func numberOfRowsInSection(_ section: Int) -> Int{
        return self.articles.count
    }
    
    func articleAtIndex(_ index: Int) -> ArticleViewModel{
        let article = self.articles[index]
        return ArticleViewModel(article)
    }
    
}

struct ArticleViewModel{
    private let article: Articulo
}

//Extension de

extension ArticleViewModel {
    init(_ article: Articulo){
        self.article = article
    }
}

//propiedades de los articulos a obtener
extension  ArticleViewModel{
    //obtener el titulo
    var titulo: String{
        return self.article.title!
    }
    var descripcion: String {
        return self.article.description!
    }
    
}
