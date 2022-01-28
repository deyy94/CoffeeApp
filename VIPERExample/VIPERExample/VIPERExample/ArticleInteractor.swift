//
//  ArticleInteractor.swift
//  VIPERExample
//
//  Created by David Guillermo Robles Sánchez on 27/01/22.
//

import Foundation

class ArticleInteractor: PresenterToInteractorProtocol{
    
    private let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=0cf790498275413a9247f8b94b3843fd")
    
    private let articleList: ArticleList! = nil
    
    var presenter: InteractorToPresenterProtocol?
    
    func fetchArticle() {
        WebService().getArticles(url: url!) { articles in
            if let articles = articles {
                self.presenter?.articleFetchedSucces(articles: articles)
            }
            else{
                self.presenter?.articleFetchFailed()
            }
        }
    }
    
    
}
