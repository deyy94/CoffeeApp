//
//  ViewController.swift
//  VIPERExample
//
//  Created by David Guillermo Robles Sánchez on 27/01/22.
//

import UIKit

class ViewController: UIViewController {
    
    var presenter: ViewToPresenterProtocol?
    var articles = [Article]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .darkGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 150
        // todo: startFetchingArticle()
        
        presenter?.startFetchingArticle()
    }


}


extension ViewController: PresenterToViewProtocol{
    func showArticle(articles: [Article]) {
        dump(articles)
        self.articles = articles
        //TODO: recargar datos de la tabla
        self.tableView.reloadData()
        
    }
    
    func showError() {
        print("Error al recuperar articulos")
    }
    
    
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TableViewCell
        cell.titleLB.text = articles[indexPath.row].title
        cell.descriptionLB.text = articles[indexPath.row].description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
}
