//
//  RegisterViewController + delegate.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 10/07/25.
//

import UIKit

class RegisterViewController___delegate: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn (_ textField: UITextField) -> Bool{
        if textField == textFieldUserName && textField.returnKeyType == .next{
            textFieldUserName.resignFirstResponder()
            textFieldEmail.becomeFirstResponder()
        }
        
        else if textField == textFieldEmail && textField.returnKeyType == .next{
            textFieldEmail.resignFirstResponder()
            textFieldPassword.becomeFirstResponder()
        }
        
        else if textField == textFieldPassword && textField.returnKeyType == .next{
            textFieldPassword.resignFirstResponder()
            textFieldConfirmPassword.becomeFirstResponder()
        }
        
        else{
            textFieldConfirmPassword.resignFirstResponder()
        }
        
        return true
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imgViewPicker.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        dismiss(animated: true)
    }
}
