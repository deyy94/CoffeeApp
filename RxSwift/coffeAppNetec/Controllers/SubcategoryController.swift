//
//  SubcategoryController.swift
//  coffeAppNetec
//
//  Created by Arlen Peña on 03/09/20.
//  Copyright © 2020 Arlen Peña. All rights reserved.
//

import UIKit

class SubcategoryController: UIViewController {

    @IBOutlet weak var lblSubCategory: UILabel!
    @IBOutlet weak var tblSubcategory: UITableView!
  
    var products = [Product]()
    var myTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblSubcategory.delegate = self
        tblSubcategory.dataSource = self
        // Do any additional setup after loading the view.
        print(myTitle)
        dump(products)
        lblSubCategory.text = myTitle
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SubcategoryController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = tblSubcategory.dequeueReusableCell(withIdentifier: "cellSub", for: indexPath) as! SubCell
        c.lblName.text = products[indexPath.row].name
        c.imgSub.image = UIImage(named: products[indexPath.row].img)
        return c
    }
    
    
}
