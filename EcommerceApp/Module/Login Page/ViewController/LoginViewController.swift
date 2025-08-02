//
//  LoginViewController.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 10/07/25.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    @IBOutlet weak var btnForgetPassword: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var scrollForm: UIScrollView!
    @IBOutlet weak var btnSetting: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let allViews = [txtEmail!, txtPassword!, btnLogin!]
        styleViews(allViews, cornerRadius: 8, borderWidth: 1, borderColor: UIColor.colorPrimary.cgColor)
        
        let alltextfields = [txtEmail, txtPassword]
        setPaddingForTextFields(alltextfields, left: 10, right: 10)
        

        
    }
    
    
    @IBAction func btnLogInClick(_ sender: Any) {
        
        let email = txtEmail.text ?? ""
        let password = txtPassword.text ?? ""
        
        if email.isEmpty && password.isEmpty {
            UIAlertController.showAlert(title: "Missing Info", message: "Please enter your email and password.", viewController: self)
        }
        
        else if email.isEmpty{
            UIAlertController.showAlert(title: "Email Is Missing", message: "Please enter your email", viewController: self)
        }
        
        else  if !isValidEmail(txtEmail.text ?? "") {
            UIAlertController.showAlert(
                title: "Invalid Email",
                message: "Please enter a valid email address.",
                viewController: self
            )
            return
        }
        
        else if password.isEmpty{
            UIAlertController.showAlert(title: "Password is Missing", message: "Please enter your password", viewController: self)
        }
        
        else if !isValidPassword(txtPassword.text ?? "") {
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
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
            let context = appDelegate.persistentContainer.viewContext
            
            let fetch: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "User")
            fetch.predicate = NSPredicate(format: "email ==[c] %@", email)
            
            do{
                let results = try context.fetch(fetch)
                guard let user = results.first else{
                    UIAlertController.showAlert(title: "Login Failed", message: "No account found with this email", viewController: self)
                    return
                }
                
                if let storedPassword = user.value(forKey: "password") as? String, storedPassword == password{
                    
                    let username = user.value(forKey: "username") as? String ?? "(no name)"
                        let email = user.value(forKey: "email") as? String ?? "(no email)"
                        let dob = user.value(forKey: "dob") as? String ?? "(no dob)"
                        var profileImage: UIImage? = nil
                        if let imageData = user.value(forKey: "profileImage") as? Data {
                            profileImage = UIImage(data: imageData)
                        }

                        // 2. Print to console (for debugging)
                        print("✅ Logged in user details:")
                        print("Username: \(username)")
                        print("Email: \(email)")
                        print("DOB: \(dob)")
                        if profileImage != nil {
                            print("Profile image is available.")
                        } else {
                            print("No profile image.")
                        }
                    
                    KeychainHelper.save(key: "LoginStatus", value: "true")
                    KeychainHelper.save(key: "LoggedInEmail", value: email.lowercased())
                    self.navigationController?.navigationBar.isHidden = true

                    let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
                    if let plvc = storyboard.instantiateViewController(withIdentifier: "ProductListViewController") as? ProductListViewController {
                        self.navigationController?.pushViewController(plvc, animated: true)
                        
                    }
                    
                }else{
                    UIAlertController.showAlert(title: "Login Failed", message: "Incorrect  Password", viewController: self)
                }
            }catch{
                UIAlertController.showAlert(title: "Error", message: "Failed to fetch user. Try again.", viewController: self)
            }
        }
    }
    
    @IBAction func btnForgotPasswordAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Forgot Password", message: "Enter your email to reset your password", preferredStyle: .alert)
        
        // 2. Add textfield
        alert.addTextField { textField in
            textField.placeholder = "Enter your email"
            textField.keyboardType = .emailAddress
        }
        
        // 3. Submit action
        let submitAction = UIAlertAction(title: "Submit", style: .default) { _ in
            if let email = alert.textFields?.first?.text {
                print("Submitted email: \(email)")
                
                if !isValidEmail(email) {
                    UIAlertController.showAlert(
                        title: "Invalid Email",
                        message: "Please enter a valid email address.",
                        viewController: self
                    )
                    return
                }
                
            }
        }
        
        // 4. Cancel action with red color
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        // 5. Add actions to alert
        alert.addAction(submitAction)
        alert.addAction(cancelAction)
        
        // 6. Present alert
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        
        self.title = "Log In"
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
        
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
        if let plvc = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController {
            self.navigationController?.pushViewController(plvc, animated: true)
        }
    }
    
    @IBAction func btnSettingClick(_ sender: Any) {
        
        self.title = "Login"
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
        
        let storyboard = UIStoryboard(name: "SettingStoryboard", bundle: nil)
        if let plvc = storyboard.instantiateViewController(withIdentifier: "SettingPageViewController") as? SettingPageViewController {
            self.navigationController?.pushViewController(plvc, animated: true)
        }
    }
}

