//
//  MenuController.swift
//  coffeAppNetec
//
//  Created by Arlen Peña on 01/09/20.
//  Copyright © 2020 Arlen Peña. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation


class MenuController: UIViewController {
    
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var tblMenu: UITableView!
    @IBOutlet weak var tblFavorites: UITableView!
    
    var user = NSLocalizedString("str_user", comment: "Guest")
    var products = [Product]()
    var favoriteProducts = [Product]()
  
    var titleToSend = ""
    var productsToSend = [Product]()
    var timeNotification: Double = 2
    
    var locationManager : CLLocationManager!
    
    let menu = [NSLocalizedString("str_drinks", comment: "Bebidas"),NSLocalizedString("str_postre", comment: "Dessert"),NSLocalizedString("str_sandwich", comment: "Sandwich")]
    let imgMenu = ["cafe2.png","mufin2.png","sandwich.png"]
    var seenError = false
    var locationStatus : NSString = "Not Started"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblMenu.delegate = self
        tblMenu.dataSource = self
        tblFavorites.dataSource = self
        tblFavorites.delegate = self
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 10
        locationManager.startMonitoringSignificantLocationChanges()
        
        
        
        
        launchNotification()
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
           if !accepted {
                 print("Notification access denied.")
           }else{
               print("notificacion exitosa")
           }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        lblWelcome.text = user
        createProducts()
        
        
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "subCategorySegue" {
          let vcd = segue.destination as! SubcategoryController
          vcd.myTitle = titleToSend
          vcd.products = productsToSend
        }
    }
    
    func createProducts() {
      products.removeAll()
      favoriteProducts.removeAll()
      
      products.append(Product(name: NSLocalizedString("product_Mokacino", comment: "Mokacino"), description: NSLocalizedString("description_moca", comment: "Mokacino"), category: .drink, price: "50", size:.small ,favorite:false, quantity: 1, img: "cafe2.png"))
      products.append(Product(name: NSLocalizedString("product_Caramel", comment: "Mokacino"), description: NSLocalizedString("description_caramel", comment: "Mokacino"), category: .drink, price: "60", size: .small, favorite: false, quantity: 1, img: "cafe2.png") )
      products.append(Product(name:NSLocalizedString("product_Expresso", comment: "Mokacino"), description: NSLocalizedString("description_expresso", comment: "Mokacino"), category: .drink, price: "40", size: .small, favorite: false, quantity:1, img: "cafe2.png"))
      products.append(Product(name: NSLocalizedString("product_Cookie", comment: "Mokacino"), description: NSLocalizedString("description_cookie", comment: "Mokacino"), category: .dessert, price: "30", size:.unique , favorite:false, quantity: 1, img: "mufin2.png"))
      products.append(Product(name: NSLocalizedString("product_Muffin", comment: "Mokacino"), description: NSLocalizedString("description_muffin", comment: "Mokacino"), category: .dessert, price: "35",size:.unique, favorite: true, quantity:1, img: "mufin2.png"))
      products.append(Product(name: NSLocalizedString("product_Sandwich", comment: "Mokacino"), description: NSLocalizedString("description_sandwich", comment: "Mokacino"), category: .sandwich, price: "90", size: .unique, favorite: true,quantity:1, img: "sandwich.png"))
      products.append(Product(name: NSLocalizedString("product_Cheese", comment: "Mokacino"), description: NSLocalizedString("description_cheese", comment: "Mokacino"), category: .sandwich, price: "90", size:.unique , favorite:false, quantity: 1, img: "sandwich.png"))
      products.append(Product(name: NSLocalizedString("product_Vegetarian", comment: "Mokacino"), description: NSLocalizedString("description_vegetarian", comment: "Mokacino"), category:.sandwich, price:"85", size: .unique, favorite: false, quantity: 1, img:"sandwich.png"))
      products.append(Product(name:NSLocalizedString("product_Carrot", comment: "Mokacino"),description: NSLocalizedString("description_carrot", comment: "Mokacino"), category: .dessert, price: "80", size:.small, favorite:true, quantity: 1, img: "mufin2.png"))
      
      favoriteProducts = products.filter({$0.favorite == true})
      dump(favoriteProducts)
      DispatchQueue.main.async {
        self.tblMenu.reloadData()
        self.tblFavorites.reloadData()
      }
    }
    
    func launchNotification(){
        print("okay leets gou")
        //set trigger
       
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeNotification, repeats: false)
    
        let center = CLLocationCoordinate2D(latitude: 20.6616192, longitude: -105.2507916)
        let region = CLCircularRegion(center: center, radius: 2000.0, identifier: "Puerto Vallarta")
        region.notifyOnEntry = true
        region.notifyOnExit = false
        let trigger2 = UNLocationNotificationTrigger(region: region, repeats: false)
       
        
        
        //content
        
        let content = UNMutableNotificationContent()
        content.title = "My first notification"
        content.subtitle = "Description of my first notification"
        content.body = "this is the body of notification"
        content.sound = .default
        content.badge = 1
        
        //Category and actions
        let rememberAction = UNNotificationAction(identifier: "rememberAction", title: "Remind me late", options: [])
        
        let deleteAction =  UNNotificationAction(identifier: "deleteAction", title: "Delete notification", options: [])
        
        let category = UNNotificationCategory(identifier: "importantActions", actions: [rememberAction,deleteAction], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        content.categoryIdentifier = "importantActions"
        
        if let path = Bundle.main.path(forResource: "slanderlogo", ofType: "jpeg"){
            let url = URL(fileURLWithPath: path)
            do{
                let attachment = try UNNotificationAttachment(identifier: "slanderlogo", url: url, options: nil)
                content.attachments = [attachment]
            }catch{
                print("La imagen no se ha cargado")
            }
        }
        
        let request = UNNotificationRequest(identifier: "TestNotification", content: content, trigger: trigger2)
        
        //remove all pendings notifications request and add the request of notification center
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) { (error) in
            print("validando si se agrego \(error)")
            if let error = error {
                
                print(" Se ha producido un error: \(error)")
            }
        }
        
    }
}

extension MenuController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        if tableView == tblFavorites{
          rows = favoriteProducts.count
        }else if tableView == tblMenu {
          rows = menu.count
      }
      return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      var c = UITableViewCell()
      if tableView == tblMenu {
        c = tblMenu.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellController
        (c as! CellController).lblNameCategory.text = menu[indexPath.row]
        (c as! CellController).imgCategory.image = UIImage(named: imgMenu[indexPath.row])
        
        //return c
      }else if tableView == tblFavorites{
        c = tblFavorites.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! CellFavorites
        (c as! CellFavorites).nameFavorite.text = favoriteProducts[indexPath.row].name
        (c as! CellFavorites).imgFavorite.image = UIImage(named: favoriteProducts[indexPath.row].img)
        
        //return c
      }
      return c
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      if tableView == tblMenu {
          //print(Category.drink.numeration())
          var filter:Category?
          titleToSend = menu[indexPath.row]
          switch indexPath.row {
            case 0:
              filter = .drink
            case 1:
              filter = .dessert
            case 2:
              filter = .sandwich
            default:
              filter = Category.none
          }
          productsToSend = products.filter({$0.category == filter})
          //dump(productsToSend)
          performSegue(withIdentifier: "subCategorySegue", sender: nil)
      }
      
    }

}

extension MenuController: UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge,.sound,.badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "rememberAction"{
            timeNotification = 20
            self.launchNotification()
        }else if response.actionIdentifier == "deleteAction"{
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["TestNotification"])
        }
    }
}

extension MenuController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        launchNotification()
    }
    private func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        if ((error) != nil) {
            if (seenError == false) {
                seenError = true
               print(error)
            }
        }
    }

    

}
