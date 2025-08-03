//
//  ProductViewController + TableViewDelegate.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 09/07/25.
//

import Foundation
import UIKit

class CartManager {
    static let shared = CartManager()
    private init() {}
    
    var cartItems: [ProductModel] = []
    
    func totalItemsCount() -> Int {
        return cartItems.count
    }
    
    func addItem(_ item: ProductModel) {
        cartItems.append(item)
    }
}

extension ProductListViewController : UITableViewDelegate, UITextFieldDelegate{
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let searchText = textField.text ?? ""
        let selectedCategoryId = indexSelectedCategory
        
        if objRedirect == .Wishlist {
            // Base is wishlist
            let wishlistItems = app.wishlistArray
            
            if wishlistItems.isEmpty {
                arrFilteredData = []
                lblEmpty.text = "WishList is empty"
                lblEmpty.isHidden = false
                tblViewProduct.isHidden = true
                return
            }
            
            arrFilteredData = wishlistItems.filter { product in
                let matchesCategory = (selectedCategoryId == 0) || (product.categoryId == selectedCategoryId)
                let matchesSearch = searchText.isEmpty || product.strTitle.lowercased().contains(searchText.lowercased())
                return matchesCategory && matchesSearch
            }
            
            lblEmpty.text = arrFilteredData.isEmpty ? "No Product found" : ""
            lblEmpty.isHidden = !arrFilteredData.isEmpty
            tblViewProduct.isHidden = arrFilteredData.isEmpty
        } else {
            // Normal mode
            arrFilteredData = arrProduct.filter { product in
                let matchesCategory = (selectedCategoryId == 0) || (product.categoryId == selectedCategoryId)
                let matchesSearch = searchText.isEmpty || product.strTitle.lowercased().contains(searchText.lowercased())
                return matchesCategory && matchesSearch
            }
            lblEmpty.text = "No Product found"
            lblEmpty.isHidden = !arrFilteredData.isEmpty
            tblViewProduct.isHidden = arrFilteredData.isEmpty
        }
        
        tblViewProduct.reloadData()
    }
    
}

extension ProductListViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFilteredData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ProductTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as! ProductTableViewCell
        
        cell.objProduct = arrFilteredData[indexPath.row]
        cell.configureCell(product: arrFilteredData[indexPath.row])
        cell.btnCartDelete.isHidden = true
        cell.ShowAlert = {
            UIAlertController.showAlert(title: "Success",
                                        message: "Product add to cart",
                                        viewController: self)
        }
        
        cell.onUpdate = {
            self.updateQuantity()
        }
        
        let product = arrFilteredData[indexPath.row]
        cell.objProduct = product
        cell.configureCell(product: product)
        
        if objRedirect == .Wishlist {
            cell.btnDeleteWishlistClick = {
                if let indexInAppWishlist = app.wishlistArray.firstIndex(where: { $0.productId == product.productId }) {
                    app.wishlistArray.remove(at: indexInAppWishlist)
                }
                self.arrFilteredData.remove(at: indexPath.row)
                self.tblViewProduct.reloadData()
                self.lblEmpty.isHidden = !self.arrFilteredData.isEmpty
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ProductStoryboard", bundle: nil)
        if let plvc = storyboard.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController {
            plvc.objProduct = arrFilteredData[indexPath.row]
            plvc.productNavTitle = arrFilteredData[indexPath.row].strTitle
            plvc.productImg2 = arrFilteredData[indexPath.row].strImageName
            plvc.intPrice = String(arrFilteredData[indexPath.row].doublePrice)
            plvc.strrDescription = String(arrFilteredData[indexPath.row].strDescription2)
            plvc.strrCategory = arrFilteredData[indexPath.row].strCategory
            plvc.strName = arrFilteredData[indexPath.row].strTitle
            
            self.navigationController?.pushViewController(plvc, animated: true)
            
        }
    }
}


