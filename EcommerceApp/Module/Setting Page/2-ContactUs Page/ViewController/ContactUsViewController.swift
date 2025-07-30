//
//  ContactUsViewController.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 11/07/25.
//

import UIKit

class ContactUsViewController: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMessage: UITextView!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var placeHolder = "Enter the message here..."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtMessage.text = placeHolder
        txtMessage.textColor = .lightGray
    
        txtName.setPadding(left: 10, right: 10)
        txtEmail.setPadding(left: 10, right: 10)
        txtMessage.textContainerInset = UIEdgeInsets(top: 10, left: 6, bottom: 10, right: 6)
        
        let allviews = [txtName!, txtEmail!, txtMessage!, btnSubmit!]
        
        styleViews(allviews, cornerRadius: 8, borderWidth: 1, borderColor: UIColor.colorPrimary.cgColor)
        
        self.title = "Contact Us"
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnContactSubmit(_ sender: Any) {
        
        let name = txtName.text ?? ""
        let email = txtEmail.text ?? ""
        
        if name.isEmpty || email.isEmpty {
            showAlert(title: "Message Info", message: "Please fill the  properly")
        }
        else{
            let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                self.navigationController?.pushViewController(plvc, animated: true)
                
                showAlert(title: "Message Received", message: "We will update you")
                
            }
        }
        
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {_ in
            
        }))
        
        self.present(alert, animated: true)
    }
    
}


extension ContactUsViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn (_ textField: UITextField) -> Bool{
        if textField == txtName && textField.returnKeyType == .next{
            txtName.resignFirstResponder()
            txtEmail.becomeFirstResponder()
        }
        else if textField == txtEmail && textField.returnKeyType == .next{
            txtEmail.resignFirstResponder()
            txtMessage.becomeFirstResponder()
        }
        else{
            txtMessage.resignFirstResponder()
        }
        return true
    }
    
}

extension ContactUsViewController : UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == placeHolder {
            textView.text = ""
            textView.textColor = .black
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = placeHolder
            textView.textColor = .lightGray
        }
        
    }
}
