//
//  AddressViewController.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 18/07/25.
//

import UIKit

class AddressViewController: UIViewController {
    
    @IBOutlet weak var lblEmpty: UILabel!
    @IBOutlet weak var btnSubmitAddress: UIButton!
    @IBOutlet weak var tblAddress: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSubmitAddress.layer.cornerRadius = 8
        self.title = "Address list"
        
        tblAddress.register(UINib(nibName: "AddressTableViewCell", bundle: nil), forCellReuseIdentifier: "AddressTableViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if arrAddressList.count == 0{
            lblEmpty.isHidden = false
            tblAddress.isHidden = true
            
        }
        
        else {
            lblEmpty.isHidden = true
            tblAddress.isHidden = false
        }
        
        tblAddress.reloadData()
    }
    
    func didAddNewAddress(_ address: Address) {
        arrAddressList.append(address)
        tblAddress.reloadData()
    }
    
    @IBAction func btnAddressAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
        if let plvc = storyboard.instantiateViewController(withIdentifier: "AddressFormViewController") as? AddressFormViewController {
            self.navigationController?.pushViewController(plvc, animated: true)
            
        }
    }
}

var arrAddressList: [Address] = []
