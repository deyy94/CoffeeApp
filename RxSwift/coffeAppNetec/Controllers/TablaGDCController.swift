//
//  TablaGDCController.swift
//  coffeAppNetec
//
//  Created by David Guillermo Robles Sánchez on 26/01/22.
//  Copyright © 2022 Arlen Peña. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import RxSwift


class TablaGDCController: UIViewController{
    
    @IBOutlet weak var tablaGDC: UITableView!
    var products = [Mobile]()
    struct DecodableType: Decodable { let Brastlewark: [Mobile] }
    let q1 = DispatchQueue.global(qos: .utility)
    let semaforo = DispatchSemaphore(value: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablaGDC.delegate = self
        tablaGDC.dataSource = self
        
        tablaGDC.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        fetchData().subscribe{ data in
            self.products = data as! [Mobile]
            
            self.tablaGDC.reloadData()
        } onError: { error in
            print(error)
        } onCompleted: {
            print("Se han terminado las tareas")
        }
    }
    
    func fetchData() -> Observable<AnyObject?>{
        print("Ejecutando")
        
        return Observable<AnyObject?>.create{ observer in
            let request = AF.request("https://raw.githubusercontent.com/salvathor/mobile_test/master/data.json")
                request.responseDecodable(of: ArrayMobile.self) { (response: AFDataResponse<ArrayMobile>) in
                    if let error = response.error{
                        observer.onError(error)
                    }else if let data = response.value?.Brastlewark
                    {
                        observer.onNext(data as AnyObject)
                        observer.onCompleted()
                    }
                }
            return Disposables.create()
        }
    }
}
extension TablaGDCController:  UITableViewDelegate, UITableViewDataSource{
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Numero de productos \(products.count)")
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        
        c = tablaGDC.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! CeldaCDGController
        (c as! CeldaCDGController).lbl1.text = products[indexPath.row].name
        (c as! CeldaCDGController).lbl2.text = "id: \(products[indexPath.row].id)"
        (c as! CeldaCDGController).img.imageFromServerURL(urlString:products[indexPath.row].thumbnail )
        return c
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
}
class CeldaCDGController: UITableViewCell{

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension UIImageView {
public func imageFromServerURL(urlString: String) {
    self.image = nil
    let urlStringNew = urlString.replacingOccurrences(of: " ", with: "%20").replacingOccurrences(of: "http", with: "https")
    print(urlStringNew)
    URLSession.shared.dataTask(with: NSURL(string: urlStringNew)! as URL, completionHandler: { (data, response, error) -> Void in

        if error != nil {
            print(error as Any)
            return
        }
        DispatchQueue.main.async(execute: { () -> Void in
            let image = UIImage(data: data!)
            self.image = image
        })

    }).resume()
}}
