//
//  LoginController.swift
//  coffeAppNetec
//
//  Created by Arlen Peña on 01/09/20.
//  Copyright © 2020 Arlen Peña. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginController: UIViewController {
    var users = [User]()
    var defaultUser = User.init(name: "arlen", password: "arlen", email: "arlen.pena@gmail.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        users.append(defaultUser)

        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var lblUser: UITextField!
    
    @IBOutlet weak var lblPass: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "logginSegue" {
            let vcd = segue.destination as! MenuController
            if lblUser.text == defaultUser.name && lblPass.text == defaultUser.password {
                vcd.user = lblUser.text!
            }
        } else if segue.identifier == "registerSegue"{
            print("entro2")
            
            //let controller = RegisterController()
            //controller.delegate = self
            let vcd = segue.destination as! RegisterController
            vcd.delegate = self
        }
    }
    
    @IBAction func btnBiometricLogin(_ sender: Any) {
        let context = LAContext()
        let usertext = "Se requiere validar su identidad"
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none){
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: usertext) { succes, error in
                if succes {
                    print("Autenticado")
                    DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "logginSegue", sender: nil)
                    }
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
    @IBAction func btnLogin(_ sender: Any) {
        if lblUser.text == "" && lblPass.text == ""{
            print("Error, campos sin datos")
        } else {
            if lblUser.text == defaultUser.name && lblPass.text == defaultUser.password{
                  print("login")
                  performSegue(withIdentifier: "logginSegue", sender: nil)
            } else { print(NSLocalizedString("str_errAccess", comment: "Error access"))}
        }
    }
    @IBAction func btnGuest(_ sender: Any) {
       print("Invitado")
       //performSegue(withIdentifier: "logginSegue", sender: nil)
    }
    
}

extension LoginController:AddUserDelegate{
    func addUser(user:User) {
        self.users.append(user)
        self.defaultUser = user
        navigationController?.popViewController(animated: true)
    }
}
