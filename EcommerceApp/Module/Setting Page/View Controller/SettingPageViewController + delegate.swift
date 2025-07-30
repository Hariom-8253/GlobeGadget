//
//  SettingPageViewController + delegate.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 11/07/25.
//

import Foundation
import UIKit

extension SettingPageViewController : UITableViewDelegate {
    
}

extension SettingPageViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let objSectionData = arrClassSettingSection[section]
        return objSectionData.arrClassSettingOption.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SettingPageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SettingPageTableViewCell", for: indexPath) as! SettingPageTableViewCell
        let sectionData = arrClassSettingSection[indexPath.section]
        let settingOption = sectionData.arrClassSettingOption[indexPath.row]
        cell.configureCell(product: settingOption)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrClassSettingSection.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let width = tableView.bounds.width
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 40))
        
        let lblHeaderName = UILabel(frame: CGRect(x: 10, y: 0, width: width, height: 40))
        lblHeaderName.text = arrClassSettingSection[section].SectionTitle
        view.addSubview(lblHeaderName)
        lblHeaderName.font = UIFont.boldSystemFont(ofSize: 20)
        lblHeaderName.textColor = .black
        
        
        return view
    }
    
    func tableView (_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sectionData = arrClassSettingSection[indexPath.section]
        let settingOption = sectionData.arrClassSettingOption[indexPath.row]
        
        switch settingOption.intTag  {
            
        case 0:
            let storyboard = UIStoryboard(name: "SettingStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "WebViewViewController") as? WebViewViewController {
                plvc.objPageType = .AboutUs
                self.navigationController?.pushViewController(plvc, animated: true)
                
            }
            break
            
        case 1:
            
            let storyboard = UIStoryboard(name: "SettingStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "WebViewViewController") as? WebViewViewController {
                plvc.objPageType = .PrivacyPolicy
                self.navigationController?.pushViewController(plvc, animated: true)
                
            }
            break
            
        case 2:
            
            let storyboard = UIStoryboard(name: "SettingStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "WebViewViewController") as? WebViewViewController {
                plvc.objPageType = .TermsAndConditions
                self.navigationController?.pushViewController(plvc, animated: true)
                
            }
            break
            
        case 3:
            
            let storyboard = UIStoryboard(name: "SettingStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "ContactUsViewController") as? ContactUsViewController {
                self.navigationController?.pushViewController(plvc, animated: true)
                
            }
            break
            
        case 4:
            
            let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "ProductListViewController") as? ProductListViewController {
                plvc.objRedirect = .Wishlist
                plvc.arrProduct = app.wishlistArray
                plvc.arrFilteredData = app.wishlistArray
                self.navigationController?.pushViewController(plvc, animated: true)
                
            }
            break
            
        case 5:
            
            let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController {
                plvc.objProfile = .EditProfile
                self.navigationController?.pushViewController(plvc, animated: true)
                
            }
            break
            
        case 6:
            
            showAlert(title: "Logging Out", message: "Are you sure you want to logout?")
            break
            
        default:
            break
        }
        
        func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(cancel)
            
            let logout = UIAlertAction(title: "LogOut", style: .destructive, handler: { _ in
                
                KeychainHelper.delete(key: "LoginStatus")
                
                self.navigationController?.navigationBar.isHidden = true
                
                let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
                if let plvc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                    self.navigationController?.pushViewController(plvc, animated: true)
                }
            })
            alert.addAction(logout)
            
            self.present(alert, animated: true)
        }
    }
}

enum PageType {
    
    case PrivacyPolicy
    case TermsAndConditions
    case AboutUs
    case Wishlist
    case EditProfile
    case ProductList
    case Register
    
}


