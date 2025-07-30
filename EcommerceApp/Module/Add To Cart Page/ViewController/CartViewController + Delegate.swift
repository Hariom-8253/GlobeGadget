//
//  CartViewController + Delegate.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 17/07/25.
//

import Foundation
import UIKit


extension CartViewController : UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return app.arrCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ProductTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as! ProductTableViewCell
        
        cell.objProduct = app.arrCart[indexPath.row]
        cell.configureCellCart(product: app.arrCart[indexPath.row])
        
        cell.onAddToCart = {
            self.calculatetotal()
        }
        
        cell.btnDeleteCartClick = {
            app.arrCart.remove(at: indexPath.row)
            self.lblEmpty.isHidden = !app.arrCart.isEmpty
            self.stackCalculation.isHidden = app.arrCart.isEmpty
            self.tblCart.reloadData()
            self.calculatetotal()
            
        }
        return cell
    }
    
    
}
