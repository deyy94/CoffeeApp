//
//  InterfaceController.swift
//  coffeAppWatch WatchKit Extension
//
//  Created by David Guillermo Robles Sánchez on 25/01/22.
//  Copyright © 2022 Arlen Peña. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var textlbl: WKInterfaceLabel!
    @IBOutlet weak var switchCtrl: WKInterfaceSwitch!
    
    
    @IBAction func btn1() {
        print("Yo funciono")
        textlbl.setText("Ouch1")
        switchCtrl.setOn(true)
    }
    
    @IBAction func btn2() {
        print("Yo funciono")
        textlbl.setText("Ouch2")
        switchCtrl.setOn(false)
    }
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        super.awake(withContext: context)
        
        print(WKInterfaceDevice.current().screenBounds.size)
        print(WKInterfaceDevice.current().batteryLevel)
        print(WKInterfaceDevice.current().waterResistanceRating)
        print(WKInterfaceDevice.current().wristLocation.rawValue)
        print(WKInterfaceDevice.current().systemName)
        print(WKInterfaceDevice.current().systemVersion)
        
        switch WKInterfaceDevice.watchSize(){
        case .Watch40mm:
            print("40 mm")
        case .Watch41mm:
            print("41 mm")
        case .Watch44mm:
            print("44 mm")
        case .Unknow:
            print("Desconocido")
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

}

enum WatchSize{
    case Watch40mm, Watch41mm, Watch44mm, Unknow
}
extension WKInterfaceDevice{
    
    class func watchSize() -> WatchSize
    {
        switch WKInterfaceDevice.current().screenBounds.size{
        case CGSize(width: 162.0, height: 197.0):
            return .Watch40mm
        case CGSize(width: 162.0, height: 197.0):
            return .Watch41mm
        case CGSize(width: 162.0, height: 197.0):
            return .Watch44mm
        default:
            return .Unknow
        
        }
    }
}
