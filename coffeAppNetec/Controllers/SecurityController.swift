//
//  SecurityController.swift
//  coffeAppNetec
//
//  Created by David Guillermo Robles Sánchez on 25/01/22.
//  Copyright © 2022 Arlen Peña. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication

class SecurityController: UIViewController{
    
    
    @IBAction func loginLA(_ sender: Any) {
        let context = LAContext()
        var error: Error?
        let usertext = "Se requiere validar su identidad"
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none){
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: usertext) { succes, error in
                if succes {
                    print("Autenticado")
                }else{
                    if let error = error as NSError?{
                        switch error.code{
                        case LAError.systemCancel.rawValue:
                            print("La autenticacion a sido cancelada por el sistema")
                        case LAError.userCancel.rawValue:
                            print("El usuario a cancelado la autenticacion")
                        case LAError.userFallback.rawValue:
                            print("se ha elegido otro metodo de autenticacion")
                        default: break
                        }
                        
                    }
                }
            }
        }else{
            print("No se ha autenticado")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
