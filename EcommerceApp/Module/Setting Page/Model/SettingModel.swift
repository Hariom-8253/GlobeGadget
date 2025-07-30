//
//  SettingModel.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 11/07/25.
//

import Foundation
import UIKit

class ClassSettingOption : NSObject{
    
    var strTitle: String = ""
    var intTag: Int = 0
    var strImage : String = ""
    var strSettingType : settingType = .contactus
    
    init(strTitle: String, intTag: Int, strImage: String, strSettingType: settingType = .contactus) {
        self.strTitle = strTitle
        self.intTag = intTag
        self.strImage = strImage
        self.strSettingType = strSettingType
    }
    
    class func populateData() -> [ClassSettingOption] {
        
        return [
            ClassSettingOption(strTitle: "Push Notification",
                               intTag: 7,
                               strImage: "bell.fill" ,
                               strSettingType: .user),
            ClassSettingOption(strTitle: "About Us",
                               intTag: 0,
                               strImage: "info.circle",
                               strSettingType: .contactus),
            ClassSettingOption(strTitle: "Privacy Policy",
                               intTag: 1,
                               strImage: "lock.shield",
                               strSettingType: .contactus),
            ClassSettingOption(strTitle: "Terms & Condition",
                               intTag: 2,
                               strImage: "doc.plaintext",
                               strSettingType: .contactus),
            ClassSettingOption(strTitle: "Contact Us",
                               intTag: 3,
                               strImage: "phone",
                               strSettingType: .contactus),
            ClassSettingOption(strTitle: "WishList",
                               intTag: 4,
                               strImage: "heart",
                               strSettingType: .user),
            ClassSettingOption(strTitle: "Edit Profile",
                               intTag: 5,
                               strImage: "person.crop.circle",
                               strSettingType: .user),
            ClassSettingOption(strTitle: "Logout",
                               intTag: 6,
                               strImage: "arrow.backward.circle",
                               strSettingType: .logout),
        ]
        
    }
    
    func printData() -> String{
        return strTitle
    }
    
}

enum settingType: String{
    case user = "User"
    case contactus = "Contact Us"
    case logout = "Logout"
    
}

class ClassSettingSection : NSObject{
    var SectionTitle : String = ""
    var arrClassSettingOption : [ClassSettingOption] = []
    
    init(SectionTitle: String, arrClassSettingOption: [ClassSettingOption]) {
        self.SectionTitle = SectionTitle
        self.arrClassSettingOption = arrClassSettingOption
    }
}
