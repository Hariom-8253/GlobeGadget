//
//  logoViewController.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 10/07/25.
//

import UIKit

class logoViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.title = "Splash"
        self.navigationController?.navigationBar.isHidden = true
        sleep(3)
        
        if KeychainHelper.get(key: "LoginStatus") == "true" {
            
            let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "ProductListViewController") as? ProductListViewController {
                self.navigationController?.pushViewController(plvc, animated: true)
                
            }
        }
        
        else{
            let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                self.navigationController?.pushViewController(plvc, animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}
