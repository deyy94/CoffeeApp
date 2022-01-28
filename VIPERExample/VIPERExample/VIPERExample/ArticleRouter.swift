//
//  ArticleRouter.swift
//  VIPERExample
//
//  Created by David Guillermo Robles Sánchez on 27/01/22.
//

import Foundation
import UIKit



class ArticleRouter: PresenterToRouterProtocol {
    
    let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
    func createModule() -> ViewController {
        //Crear modulo VIPER para Article
        let view = sb.instantiateViewController(withIdentifier: "ArticleMainVC") as! ViewController
        
        let interactor: PresenterToInteractorProtocol = ArticleInteractor()
                
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = ArticlePresenter()
        
        let router: PresenterToRouterProtocol = ArticleRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return view
        
    }
    func pushToAnotherScreen() {
        
    }
}
