//
//  SettingPageViewController.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 11/07/25.
//

import UIKit
import CoreData

class SettingPageViewController: UIViewController {
    
    var arrClassSettingSection : [ClassSettingSection] = []
    var arrSettingOption : [ClassSettingOption] = ClassSettingOption.populateData()
    var productList: [ProductModel] = []
    
    @IBOutlet weak var tblSetting: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBarUserItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        arrClassSettingSection.append(ClassSettingSection(SectionTitle: "User", arrClassSettingOption: arrSettingOption.filter{$0.strSettingType == .user}))
        arrClassSettingSection.append(ClassSettingSection(SectionTitle: "Contact Us", arrClassSettingOption: arrSettingOption.filter{$0.strSettingType == .contactus}))
        arrClassSettingSection.append(ClassSettingSection(SectionTitle: "Logout", arrClassSettingOption: arrSettingOption.filter{$0.strSettingType == .logout}))
        
        self.title = "Settings"
                
        tblSetting.register(UINib(nibName: "SettingPageTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingPageTableViewCell")
        
        UITableView.appearance().sectionHeaderTopPadding = 0
    }
    
    private func setupNavBarUserItem() {
        // Check login status
        let isLoggedIn = (KeychainHelper.get(key: "LoginStatus") == "true")
        if isLoggedIn, let user = fetchLoggedInUser(),
           let imageData = user.value(forKey: "profileImage") as? Data,
           let profileImage = UIImage(data: imageData) {

            // show profile image (same as before)
            let size: CGFloat = 34
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: 0, y: 0, width: size, height: size)
            button.layer.cornerRadius = size / 2
            button.clipsToBounds = true
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.imageView?.contentMode = .scaleAspectFill
            button.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
            button.addTarget(self, action: #selector(profileImageTapped), for: .touchUpInside)
            button.widthAnchor.constraint(equalToConstant: size).isActive = true
            button.heightAnchor.constraint(equalToConstant: size).isActive = true

            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        } else {
            // show login button
            let loginButton = UIBarButtonItem(title: "Login", style: .plain, target: self, action: #selector(loginTapped))
            self.navigationItem.rightBarButtonItem = loginButton
        }
    }
    
    @objc private func loginTapped() {
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func fetchLoggedInUser() -> NSManagedObject? {
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
    
    @objc private func profileImageTapped() {
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController {
            vc.objProfile = .EditProfile
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }


}
