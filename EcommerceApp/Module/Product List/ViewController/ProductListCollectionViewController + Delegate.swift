//
//  ProductListCollectionViewController + Delegate.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 19/07/25.
//

import Foundation
import UIKit

extension ProductListViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCollectionViewCell", for: indexPath) as! ProductListCollectionViewCell
        
        let currentCategory = arrCategory[indexPath.item]
        
        cell.lblTitle.text = currentCategory.category_display_name
        
        if indexSelectedCategory == indexPath.item {
            cell.viewMain.backgroundColor = UIColor.colorPrimary
            cell.lblTitle.textColor = .white
        } else {
            cell.viewMain.backgroundColor = .white
            cell.lblTitle.textColor = .black
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSizeMake(130, 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexSelectedCategory = arrCategory[indexPath.item].category_id
        
        collectionView.reloadData()
        
        let selectedCategory = arrCategory[indexPath.item].category_id
        
        if selectedCategory == 0 {
            arrFilteredData = arrProduct
        } else {
            arrFilteredData = arrProduct.filter {
                $0.categoryId == indexSelectedCategory
            }
        }
        
        tblViewProduct.reloadData()
    }
}
