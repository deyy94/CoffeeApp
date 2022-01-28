//
//  RegistreController.swift
//  coffeAppNetec
//
//  Created by Arlen Peña on 01/09/20.
//  Copyright © 2020 Arlen Peña. All rights reserved.
//

import UIKit

protocol AddUserDelegate {
    func addUser(user:User)
}

class RegisterController: UIViewController {

    var delegate : AddUserDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var txtUser: UITextField!
    
    @IBOutlet weak var txtPass: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBAction func btnRegister(_ sender: Any) {
        
        guard let name = txtUser.text, txtUser.hasText, let pass = txtPass.text, txtPass.hasText, let email = txtEmail.text, txtEmail.hasText else {
            print("error")
            return
        }
        let user = User(name: name, password: pass, email: email)
        delegate?.addUser(user: user)
        
    }
}
