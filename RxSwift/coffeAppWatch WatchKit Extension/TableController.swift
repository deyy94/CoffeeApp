//
//  InterfaceController.swift
//  coffeAppWatch WatchKit Extension
//
//  Created by David Guillermo Robles Sánchez on 25/01/22.
//  Copyright © 2022 Arlen Peña. All rights reserved.
//

import WatchKit
import Foundation

class MyRowController: NSObject {

    @IBOutlet weak var myImage: WKInterfaceImage!
    @IBOutlet weak var myLabel: WKInterfaceLabel!
}
class TableController: WKInterfaceController {
    
    @IBOutlet weak var table: WKInterfaceTable!
    
    let stringData = ["Expresso", "Sandwich", "Mokacino", "Muffin", "Cheese"]
    let imageData = ["cafe", "sandwich", "cafe2", "mufin2", "mufin"]
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        super.awake(withContext: context)
  
    }
    override init() {
        super.init()
        loadTable()
    }
    func loadTable() {
        print("Se pintaran \(stringData.count) ")
        table.setNumberOfRows(stringData.count,
            withRowType: "MyRowController")

        for (index, labelText) in stringData.enumerated() {
            print(index)
            let row = table.rowController(at: index)
            as! MyRowController
            row.myLabel.setText(labelText)
            row.myImage.setImage(UIImage(named: imageData[index]))
        }
    }
    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

}

