//
//  AddressViewController + Delegate.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 18/07/25.
//

import Foundation
import UIKit

extension AddressViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAddressList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : AddressTableViewCell = tblAddress.dequeueReusableCell(withIdentifier: "AddressTableViewCell", for: indexPath) as! AddressTableViewCell
        
        let obj = arrAddressList[indexPath.row]
        cell.lblFirstName.text = "\(obj.strFirstName ?? "")"
        cell.lblLastName.text = "\(obj.strLastName ?? "")"
        cell.lblEmail.text = "\(obj.strEmail ?? "")"
        cell.lblMObileNO.text = "\(obj.intMobileNo ?? 0)"
        cell.lblDob.text = "\(obj.intAge ?? 0)"
        cell.lblState.text = "\(obj.strState ?? "")"
        cell.lblCity.text = "\(obj.strCity ?? "")"
        cell.lblAdd1.text = "\(obj.strAddress1 ?? "")"
        cell.lblAdd2.text = "\(obj.strAddress2 ?? "")"
        cell.lblPincode.text = "\(obj.intPincode ?? 0)"
        
        cell.btnDeleteClick = {
            arrAddressList.remove(at: indexPath.row)
            self.lblEmpty.isHidden = !arrAddressList.isEmpty
            self.tblAddress.reloadData()
        }
        
        cell.btnEditClick = {
            let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
            if let plvc = storyboard.instantiateViewController(withIdentifier: "AddressFormViewController") as? AddressFormViewController {
                plvc.objAddress = arrAddressList[indexPath.row]
                self.navigationController?.pushViewController(plvc, animated: true)
            }
        }
        
        return cell
    }
}


