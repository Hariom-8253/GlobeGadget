//
//  SettingPageViewController.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 11/07/25.
//

import UIKit

class SettingPageViewController: UIViewController {
    
    var arrClassSettingSection : [ClassSettingSection] = []
    var arrSettingOption : [ClassSettingOption] = ClassSettingOption.populateData()
    var productList: [ProductModel] = []
    
    @IBOutlet weak var tblSetting: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrClassSettingSection.append(ClassSettingSection(SectionTitle: "User", arrClassSettingOption: arrSettingOption.filter{$0.strSettingType == .user}))
        arrClassSettingSection.append(ClassSettingSection(SectionTitle: "Contact Us", arrClassSettingOption: arrSettingOption.filter{$0.strSettingType == .contactus}))
        arrClassSettingSection.append(ClassSettingSection(SectionTitle: "Logout", arrClassSettingOption: arrSettingOption.filter{$0.strSettingType == .logout}))
        
        self.title = "Settings"
        
        // Do any additional setup after loading the view.
        
        tblSetting.register(UINib(nibName: "SettingPageTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingPageTableViewCell")
        
        UITableView.appearance().sectionHeaderTopPadding = 0
    }
}
