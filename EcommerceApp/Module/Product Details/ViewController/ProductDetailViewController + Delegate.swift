//
//  ProductDetailViewController + Delegate.swift
//  EcommerceApp
//
//  Created by Hariom Sharma on 19/07/25.
//

import Foundation
import UIKit

extension ProductDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImg.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductDetailCollectionViewCell", for: indexPath) as! ProductDetailCollectionViewCell
        
        let imageName = arrImg[indexPath.item]
        cell.imgProductDetail.image = UIImage (named: imageName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 320)
    }
    
}

extension ProductDetailViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrReview.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblReview.dequeueReusableCell(withIdentifier: "ProductReviewTableViewCell", for: indexPath) as! ProductReviewTableViewCell
        
        cell.configreviewcell(reviewmodel: arrReview[indexPath.row])
        
        return cell
        
    }
}
