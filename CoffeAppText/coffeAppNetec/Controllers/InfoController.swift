//
//  InfoController.swift
//  coffeAppNetec
//
//  Created by David Guillermo Robles Sánchez on 25/01/22.
//  Copyright © 2022 Arlen Peña. All rights reserved.
//

import Foundation
import UIKit
class InfoController: UIViewController{
    var fruits = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fruits = readPlist(withName: "Fruits")!
        print(fruits)
        
        let serverUrl = Bundle.main.object(forInfoDictionaryKey: "ServerUrl") as! String
    
        print(serverUrl)
        
        let btnCrear = UIButton(frame: CGRect(x: 10, y: 100, width: 200, height: 30))
        btnCrear.setTitle("Crear keychain item", for: .normal)
        btnCrear.backgroundColor = .black
        btnCrear.addTarget(self, action: #selector(crearItem), for: .touchUpInside)
        
        
        let btnLeer = UIButton(frame: CGRect(x: 10, y: 300, width: 200, height: 30))
        btnLeer.setTitle("leer keychain item", for: .normal)
        btnLeer.backgroundColor = .black
        btnLeer.addTarget(self, action: #selector(leerItem), for: .touchUpInside)
        
        
        
        self.view.addSubview(btnCrear)
        self.view.addSubview(btnLeer)
        
    }
    @objc func crearItem(){
        var dict = [String:AnyObject]()
        
        dict[kSecClass as String] = kSecClassGenericPassword
        
        dict[kSecAttrAccessible as String] = kSecAttrAccessibleWhenUnlocked
        
        dict[kSecAttrLabel as String] = "com.netec.keychain" as CFString
        
        dict[kSecAttrAccount as String] = "jsRobles" as CFString
        
        dict[kSecAttrService as String] = "jsRobles_Services" as CFString
        
        dict[kSecValueData as String] = "qwerty123".data(using: .utf8)! as CFData
        
        dict[kSecReturnAttributes as String] = kCFBooleanTrue
        
        var result: AnyObject?
        let status = withUnsafeMutablePointer(to: &result){
            SecItemAdd(dict as CFDictionary, UnsafeMutablePointer($0))
        }
        //let newAttributes = result as! Dictionary<String,AnyObject>
        dump(status)
       // dump(newAttributes)
        
    }
    @objc func leerItem(){
        var dict = [CFString:AnyObject]()
        dict[kSecClass] = kSecClassGenericPassword
        
        dict[kSecAttrLabel] = "com.netec.keychain" as CFString
        
        dict[kSecAttrAccount] = "jsRobles" as CFString
        
        dict[kSecAttrService] = "jsRobles_Services" as CFString
        
        dict[kSecReturnAttributes] = kCFBooleanTrue
        
        var qResponse : AnyObject?
        let status = withUnsafeMutablePointer(to: &qResponse){
            SecItemCopyMatching(dict as CFDictionary, UnsafeMutablePointer($0))
        }
        
        let pass = String(data: qResponse as! Data,encoding: .utf8)!
        
        dump(pass)
    }
    func readPlist(withName name: String) -> [String]?{
        if let path = Bundle.main.path(forResource: name, ofType: "plist"){
            let contentPlist = FileManager.default.contents(atPath: path)
            return (try? PropertyListSerialization.propertyList(from: contentPlist!, options: .mutableContainersAndLeaves, format: nil)) as? [String]
        }
        return nil
    }
}
