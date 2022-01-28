//
//  ViewController.swift
//  MVVMExample
//
//  Created by David Guillermo Robles Sánchez on 27/01/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var articleListVM: ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 150
        loadData()
    }
    
    func loadData(){
        print("trabajando")
        let url =  URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=0cf790498275413a9247f8b94b3843fd")!
        WebService().getArticules(url: url) { articles in
            
            self.articleListVM = ArticleListViewModel(articles: articles!)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }


}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleListVM.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TableViewCell
        
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
        c.titleLb.text = articleVM.titulo
        c.descriprionLB.text = articleVM.descripcion
        
        return c
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return articleListVM == nil ? 0 : articleListVM.numberOfSection
    }
    
    
    
    
}

