//
//  ArticleProtocols.swift
//  VIPERExample
//
//  Created by David Guillermo Robles Sánchez on 27/01/22.
//

import Foundation
import UIKit

//

protocol ViewToPresenterProtocol: AnyObject{
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    
    func startFetchingArticle()
    
    
}

//Protocolo que sera implementado en ViewController.swift
protocol PresenterToViewProtocol: AnyObject{
    func showArticle(articles:  [Article])
    func showError()
}
protocol PresenterToRouterProtocol: AnyObject{
    func createModule() -> ViewController
    func pushToAnotherScreen() 
}
protocol PresenterToInteractorProtocol: AnyObject{
    var presenter:  InteractorToPresenterProtocol? {get set}
    func fetchArticle()
    
}
protocol InteractorToPresenterProtocol:AnyObject{
    func articleFetchedSucces(articles:[Article])
    func articleFetchFailed()
    
}
