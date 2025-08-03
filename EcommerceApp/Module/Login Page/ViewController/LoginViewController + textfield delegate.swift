//
//  LoginViewController + textfield delegate.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 10/07/25.
//

import UIKit

class LoginViewController___textfield_delegate: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

//To move the cursor to next textfield

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn (_ textField: UITextField) -> Bool{
        if textField == txtEmail && textField.returnKeyType == .next{
            txtEmail.resignFirstResponder()
            txtPassword.becomeFirstResponder()
        }
        else{
            txtPassword.resignFirstResponder()
        }
        return true
    }
}



