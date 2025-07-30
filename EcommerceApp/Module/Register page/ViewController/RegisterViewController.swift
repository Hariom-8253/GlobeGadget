//
//  RegisterViewController.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 10/07/25.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var viewdate: UIView!
    @IBOutlet weak var btnDatePicker: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var textFieldConfirmPassword: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var textFieldUserName: UITextField!
    
    var objProfile : PageType = .Register
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if objProfile == .EditProfile{
            self.title = "Edit Profile"
            btnRegister.setTitle("Update", for: .normal)
            
        }else{
            self.title = "Register"
        }
        
        let allViews = [textFieldUserName!,textFieldEmail!, textFieldPassword!, textFieldPassword!, textFieldConfirmPassword!, btnRegister!, viewdate!]
        styleViews(allViews, cornerRadius: 8, borderWidth: 1, borderColor: UIColor.colorPrimary.cgColor)
        
        let allTextFields = [textFieldEmail, textFieldPassword, textFieldConfirmPassword, textFieldUserName]
        setPaddingForTextFields(allTextFields, left: 10, right: 10)
        
//        textFieldEmail.setPadding(left: 10, right: 10)
//        textFieldPassword.setPadding(left: 10, right: 10)
//        textFieldUserName.setPadding(left: 10, right: 10)
//        textFieldConfirmPassword.setPadding(left: 10, right: 10)

    }
    
    func isValidDOB(_ dobString: String) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        guard let dobDate = formatter.date(from: dobString) else {
            return false
        }
        
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year], from: dobDate, to: now)
        
        if let age = ageComponents.year {
            return age >= 18
        }
        return false
    }
    
    @IBAction func btnDatePickerAction(_ sender: Any) {
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.preferredDatePickerStyle = .wheels
        let alert = UIAlertController(title: "Select Date of Birth", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        alert.isModalInPresentation = true
        datePicker.frame = CGRect(x: 0, y: 30, width: alert.view.bounds.width - 20, height: 200)
        alert.view.addSubview(datePicker)
        let ok = UIAlertAction(title: "Done", style: .default) { _ in
            self.lblDate.textColor = .black
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            self.lblDate.text = formatter.string(from: datePicker.date)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func buttonSumit(_ sender: Any) {
        
        let username = textFieldUserName.text ?? ""
        let confirmpassword = textFieldConfirmPassword.text ?? ""
        let email = textFieldEmail.text ?? ""
        let password = textFieldPassword.text ?? ""
        
        
        if password.isEmpty && confirmpassword.isEmpty && username.isEmpty {
            UIAlertController.showAlert(title: "Missing Info", message: "Please enter your username password and confirm password.",viewController : self)
        }
        
        else if email.isEmpty  && confirmpassword.isEmpty && username.isEmpty {
            UIAlertController.showAlert(title: "Missing Info", message: "Please enter your username email and confirmpassword .",viewController : self)
        }
        
        
        else if email.isEmpty && password.isEmpty  && username.isEmpty {
            UIAlertController.showAlert(title: "Missing Info", message: "Please enter your username email and password.",viewController : self)
        }
        
        else if email.isEmpty && password.isEmpty && confirmpassword.isEmpty  {
            UIAlertController.showAlert(title: "Missing Info", message: "Please enter your email password and confirmpassword.",viewController : self)
        }
        
        else if username.isEmpty && email.isEmpty  {
            UIAlertController.showAlert(title: "Missing Info", message: "Please enter your  username and email. ",viewController : self)
        }
        
        else if username.isEmpty && password.isEmpty  {
            UIAlertController.showAlert(title: "Missing Info", message: "Please enter your  username and password. ",viewController : self)
        }
        
        else if username.isEmpty && confirmpassword.isEmpty  {
            UIAlertController.showAlert(title: "Missing Info", message: "Please enter your  username and confirmpassword. ",viewController : self)
        }
        
        else if email.isEmpty && password.isEmpty  {
            UIAlertController.showAlert(title: "Missing Info", message: "Please enter your  email and password. ",viewController : self)
        }
        
        else if email.isEmpty && confirmpassword.isEmpty  {
            UIAlertController.showAlert(title: "Missing Info", message: "Please enter your  email and confirmpassword. ",viewController : self)
        }
        
        else if password.isEmpty && confirmpassword.isEmpty  {
            UIAlertController.showAlert(title: "Missing Info", message: "Please enter your  password and confirmpassword. ",viewController : self)
        }
        
        else if username.isEmpty  {
            UIAlertController.showAlert(title: "UserName Is Missing", message: "Please enter your username",viewController : self)
        }
        
        else if confirmpassword.isEmpty{
            UIAlertController.showAlert(title: "Confirm Password Is Missing", message: "Please enter your confirmpassword",viewController : self)
        }
        
        else if email.isEmpty{
            UIAlertController.showAlert(title: "Email Is Missing", message: "Please enter your email",viewController : self)
        }
        
        else if password.isEmpty{
            UIAlertController.showAlert(title: "Password is Missing", message: "Please enter your password",viewController : self)
        }
        
        else  if !isValidEmail(textFieldEmail.text ?? "") {
            UIAlertController.showAlert(
                title: "Invalid Email",
                message: "Please enter a valid email address.",
                viewController: self
            )
            return
        }
        
        else if !isValidPassword(textFieldPassword.text ?? "") {
            UIAlertController.showAlert(
                title: "Invalid Password",
                message: """
                                    Password must be at least 8 characters long, 
                                    contain at least 1 uppercase letter, 
                                    1 lowercase letter, 1 number, and 1 special character.
                                    """,
                viewController: self
            )
            return
        }
        
        else{
            
            if confirmpassword != password{
                UIAlertController.showAlert(title: "Passwrods Do Not Match", message: "password and confirm password fields must be same, Please try again ",viewController : self)
            }
            
            else {
                self.title = "Register"
                self.navigationController?.navigationBar.isHidden = false
                self.navigationItem.hidesBackButton = false
                
                if objProfile == .ProductList{
                    
                    let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
                    if let productvc = storyboard.instantiateViewController(withIdentifier: "ProductListViewController") as? ProductListViewController {
                        self.navigationController?.pushViewController(productvc, animated: true)
                        
                    }
                }
                
                else {
                    
                    let storyboard = UIStoryboard(name: "SettingStoryboard", bundle: nil)
                    if let settingvc = storyboard.instantiateViewController(withIdentifier: "SettingPageViewController") as? SettingPageViewController {
                        self.navigationController?.pushViewController(settingvc, animated: true)
                        
                    }
                }
            }
        }
    }
}

