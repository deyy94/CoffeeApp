//
//  ArticlePresenter.swift
//  VIPERExample
//
//  Created by David Guillermo Robles Sánchez on 27/01/22.
//

import Foundation

class ArticlePresenter: ViewToPresenterProtocol{
    
   
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
    
    func startFetchingArticle() {
        interactor?.fetchArticle()
    }
    
    
    
}
extension ArticlePresenter: InteractorToPresenterProtocol{
    func articleFetchedSucces(articles article: [Article]) {
        DispatchQueue.main.async {
            self.view?.showArticle(articles: article)
        }
        
    }
    
    func articleFetchFailed() {
        self.view?.showError()
    }
    
    
}
