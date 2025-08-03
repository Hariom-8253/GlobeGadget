//
//  RegisterViewController.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 10/07/25.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var imgViewPicker: UIImageView!
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
        
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(addImage))
        imgViewPicker.addGestureRecognizer(imageGesture)
        
        if objProfile == .EditProfile{
            self.title = "Edit Profile"
            btnRegister.setTitle("Update", for: .normal)
            
            if let user = fetchCurrentUserObject() {
                textFieldUserName.text = user.value(forKey: "username") as? String
                textFieldEmail.text = user.value(forKey: "email") as? String
                lblDate.text = user.value(forKey: "dob") as? String
                if let imageData = user.value(forKey: "profileImage") as? Data {
                    imgViewPicker.image = UIImage(data: imageData)
                }
            }
            
        }else{
            self.title = "Register"
        }
        
        let allViews = [textFieldUserName!,textFieldEmail!, textFieldPassword!, textFieldPassword!, textFieldConfirmPassword!, btnRegister!, viewdate!]
        styleViews(allViews, cornerRadius: 8, borderWidth: 1, borderColor: UIColor.colorPrimary.cgColor)
        
        let allTextFields = [textFieldEmail, textFieldPassword, textFieldConfirmPassword, textFieldUserName]
        setPaddingForTextFields(allTextFields, left: 10, right: 10)
        
        
    }
    
    private func fetchCurrentUserObject() -> NSManagedObject? {
        guard let savedEmail = KeychainHelper.get(key: "LoggedInEmail")?.lowercased(),
              let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        let context = appDelegate.persistentContainer.viewContext
        let fetch: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "User")
        fetch.predicate = NSPredicate(format: "email == %@", savedEmail)
        if let result = try? context.fetch(fetch), let user = result.first {
            return user
        }
        return nil
    }
    
    
    @objc func addImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        present(pickerController, animated: true)
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
        
        let userimage = imgViewPicker.image
        let username = textFieldUserName.text ?? ""
        let confirmpassword = textFieldConfirmPassword.text ?? ""
        let email = textFieldEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
        let password = textFieldPassword.text ?? ""
        
        switch true {
            
        case username.isEmpty:
            UIAlertController.showAlert(title: "UserName Is Missing", message: "Please enter your username", viewController: self)
            return
            
        case email.isEmpty:
            UIAlertController.showAlert(title: "Email Is Missing", message: "Please enter your email", viewController: self)
            return
            
        case !isValidEmail(textFieldEmail.text ?? ""):
            UIAlertController.showAlert(
                title: "Invalid Email",
                message: "Please enter a valid email address.",
                viewController: self
            )
            return
            
        case password.isEmpty:
            UIAlertController.showAlert(title: "Password is Missing", message: "Please enter your password", viewController: self)
            return
            
        case !isValidPassword(textFieldPassword.text ?? ""):
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
            
        case confirmpassword.isEmpty:
            UIAlertController.showAlert(title: "Confirm Password Is Missing", message: "Please enter your confirm password", viewController: self)
            return
            
        default:
            break
        }
        
        if confirmpassword != password {
            UIAlertController.showAlert(title: "Passwords Do Not Match", message: "Password and confirm password fields must be same, please try again.", viewController: self)
            return
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        if objProfile == .EditProfile {
            guard let user = fetchCurrentUserObject() else {
                UIAlertController.showAlert(title: "Error", message: "Could not find user to update.", viewController: self)
                return
            }
            
            let originalEmail = (user.value(forKey: "email") as? String ?? "").lowercased()
            let newEmail = email.lowercased()
            
            if newEmail != originalEmail {
                
                let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "User")
                fetchRequest.predicate = NSPredicate(format: "email == %@", newEmail)
                if let existing = try? context.fetch(fetchRequest), existing.count > 0 {
                    UIAlertController.showAlert(title: "Email Taken", message: "An account with this email already exists.", viewController: self)
                    return
                    
                }
            }
            
            user.setValue(username, forKey: "username")
            user.setValue(newEmail, forKey: "email")
            user.setValue(password, forKey: "password")
            user.setValue(lblDate.text ?? "", forKey: "dob")
            if let image = imgViewPicker.image, let imageData = image.jpegData(compressionQuality: 0.8) {
                user.setValue(imageData, forKey: "profileImage")
            }
            
            do {
                try context.save()
                if newEmail != originalEmail {
                    KeychainHelper.save(key: "LoggedInEmail", value: newEmail)
                }
                
                let storyboard = UIStoryboard(name: "SettingStoryboard", bundle: nil)
                if ((storyboard.instantiateViewController(withIdentifier: "SettingPageViewController") as? SettingPageViewController) != nil) {
                    self.navigationController?.popViewController(animated: true)
                    UIAlertController.showAlert(title: "Success", message: "Profile updated.", viewController: self)
                }
            } catch {
                UIAlertController.showAlert(title: "Save Error", message: "Failed to update profile. Try again.", viewController: self)
            }
            
        }
        
        else {
            
            let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "User")
            fetchRequest.predicate = NSPredicate(format: "email == %@", email)
            if let existing = try? context.fetch(fetchRequest), existing.count > 0 {
                UIAlertController.showAlert(title: "Email Taken", message: "An account with this email already exists.", viewController: self)
                return
            }
            
            guard let userEntity = NSEntityDescription.entity(forEntityName: "User", in: context) else { return }
            let user = NSManagedObject(entity: userEntity, insertInto: context)
            user.setValue(username, forKey: "username")
            user.setValue(email, forKey: "email")
            user.setValue(password, forKey: "password")
            user.setValue(lblDate.text ?? "", forKey: "dob")
            if let image = imgViewPicker.image, let imageData = image.jpegData(compressionQuality: 0.8) {
                user.setValue(imageData, forKey: "profileImage")
            }
            
            do {
                try context.save()
                let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
                if let productvc = storyboard.instantiateViewController(withIdentifier: "ProductListViewController") as? ProductListViewController {
                    self.navigationController?.pushViewController(productvc, animated: true)
                }
                print("✅ User registered successfully with image.")
            } catch let error as NSError {
                print("❌ Failed to save user: \(error.localizedDescription)")
            }
        }
    }
}

